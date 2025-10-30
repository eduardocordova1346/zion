<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { useForm } from '@inertiajs/vue3';

defineOptions({ layout: AppLayout });

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
    <h1 class="text-xl font-semibold text-gray-900">Alterar senha</h1>

    <form class="mt-6 max-w-lg space-y-5" @submit.prevent="updatePassword">
      <div>
        <label for="current_password" class="block text-sm font-medium text-gray-700">Senha atual</label>
        <input id="current_password" type="password" v-model="passwordForm.current_password" autocomplete="current-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-gray-200" />
        <div v-if="passwordForm.errors.current_password" class="mt-1 text-sm text-red-600">{{ passwordForm.errors.current_password }}</div>
      </div>
      <div>
        <label for="password" class="block text-sm font-medium text-gray-700">Nova senha</label>
        <input id="password" type="password" v-model="passwordForm.password" autocomplete="new-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-gray-200" />
        <div v-if="passwordForm.errors.password" class="mt-1 text-sm text-red-600">{{ passwordForm.errors.password }}</div>
      </div>
      <div>
        <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmar nova senha</label>
        <input id="password_confirmation" type="password" v-model="passwordForm.password_confirmation" autocomplete="new-password" required class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-gray-200" />
      </div>
      <button type="submit" :disabled="passwordForm.processing" class="inline-flex items-center rounded-md bg-gray-900 px-4 py-2 text-sm text-white hover:bg-gray-800 disabled:opacity-70">Atualizar senha</button>
    </form>
  </div>
</template>
