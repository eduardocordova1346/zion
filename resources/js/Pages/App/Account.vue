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
  // Placeholder: send to a future route like route('account.update')
  // For now, just prevent default to keep page structure ready
}

const passwordForm = useForm({
  current_password: '',
  password: '',
  password_confirmation: '',
});

function updatePassword() {
  passwordForm.put(route('password.update'), {
    preserveScroll: true,
    onSuccess: () => passwordForm.reset(),
  });
}
</script>

<template>
  <div class="p-6">
    <h1 class="text-xl font-semibold text-gray-900">Minha conta</h1>

    <form class="mt-6 max-w-lg space-y-5" @submit.prevent="submit">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Nome</label>
        <input id="name" v-model="form.name" type="text" class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-200" />
      </div>
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700">E-mail</label>
        <input id="email" v-model="form.email" type="email" class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-200" />
      </div>
      <button type="submit" class="inline-flex items-center rounded-md bg-gray-900 px-4 py-2 text-sm text-white hover:bg-gray-800">Salvar</button>
    </form>

    <div class="mt-10 max-w-lg">
      <h2 class="text-lg font-semibold text-gray-900">Alterar senha</h2>
      <form class="mt-4 space-y-5" @submit.prevent="updatePassword">
        <div>
          <label for="current_password" class="block text-sm font-medium text-gray-700">Senha atual</label>
          <input id="current_password" type="password" v-model="passwordForm.current_password" autocomplete="current-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-200" />
          <div v-if="passwordForm.errors.current_password" class="mt-1 text-sm text-red-600">{{ passwordForm.errors.current_password }}</div>
        </div>
        <div>
          <label for="password" class="block text-sm font-medium text-gray-700">Nova senha</label>
          <input id="password" type="password" v-model="passwordForm.password" autocomplete="new-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-200" />
          <div v-if="passwordForm.errors.password" class="mt-1 text-sm text-red-600">{{ passwordForm.errors.password }}</div>
        </div>
        <div>
          <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmar nova senha</label>
          <input id="password_confirmation" type="password" v-model="passwordForm.password_confirmation" autocomplete="new-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-200" />
        </div>
        <button type="submit" :disabled="passwordForm.processing" class="inline-flex items-center rounded-md bg-gray-900 px-4 py-2 text-sm text-white hover:bg-gray-800 disabled:opacity-70">Atualizar senha</button>
      </form>
    </div>
  </div>
</template>
