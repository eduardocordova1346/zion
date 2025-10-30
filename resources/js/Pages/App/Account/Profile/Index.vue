<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { useForm, usePage } from '@inertiajs/vue3';
import { computed } from 'vue';

defineOptions({ layout: AppLayout });

const page = usePage();
const user = computed(() => page.props.auth?.user ?? {});

const form = useForm({
  name: user.value?.name ?? '',
  email: user.value?.email ?? '',
});

function submit() {
  form.patch(route('account.profile.update'));
}
</script>

<template>
  <div class="p-6">
    <h1 class="text-xl font-semibold text-gray-900">Alterar dados da conta</h1>

    <form class="mt-6 max-w-lg space-y-5" @submit.prevent="submit">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Nome</label>
        <input id="name" v-model="form.name" type="text" class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-gray-200" />
      </div>
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700">E-mail</label>
        <input id="email" v-model="form.email" type="email" class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-gray-200" />
      </div>
      <button type="submit" class="inline-flex items-center rounded-md bg-gray-900 px-4 py-2 text-sm text-white hover:bg-gray-800">Salvar</button>
    </form>
  </div>
</template>
