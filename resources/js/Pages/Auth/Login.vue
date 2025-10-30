<script setup>
import { useForm, Link } from '@inertiajs/vue3';
import { computed } from 'vue';
import { EnvelopeIcon, LockClosedIcon } from '@heroicons/vue/24/outline';

const props = defineProps({
  canResetPassword: { type: Boolean, default: false },
  status: { type: String, default: '' },
});

const form = useForm({
  email: '',
  password: '',
  remember: false,
});

const isDisabled = computed(() => form.processing);

function submit() {
  form.post(route('login'));
}
</script>

<template>
  <div class="min-h-screen bg-gray-50 flex items-center justify-center px-4">
    <div class="w-full max-w-md bg-white rounded-lg shadow-md p-6 border border-gray-200">
      <h1 class="text-2xl font-bold text-center text-gray-900">Entrar</h1>
      <div v-if="status" class="mt-4 text-sm text-green-600">{{ status }}</div>
      <form class="mt-6 space-y-5" @submit.prevent="submit">
        <div>
          <label for="email" class="block text-sm font-medium text-gray-700">E-mail</label>
          <div class="relative mt-1">
            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
              <EnvelopeIcon class="h-5 w-5 text-gray-400" />
            </span>
            <input
              id="email"
              type="email"
              v-model="form.email"
              required
              autocomplete="username"
              class="block w-full rounded-md border border-gray-300 bg-white pl-10 pr-3 py-1.5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-gray-200"
              placeholder="seu@email.com"
            />
          </div>
          <div v-if="form.errors.email" class="mt-1 text-sm text-red-600">{{ form.errors.email }}</div>
        </div>
        <div>
          <label for="password" class="block text-sm font-medium text-gray-700">Senha</label>
          <div class="relative mt-1">
            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
              <LockClosedIcon class="h-5 w-5 text-gray-400" />
            </span>
            <input
              id="password"
              type="password"
              v-model="form.password"
              required
              autocomplete="current-password"
              class="block w-full rounded-md border border-gray-300 bg-white pl-10 pr-3 py-1.5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-gray-200"
              placeholder="••••••••"
            />
          </div>
          <div v-if="form.errors.password" class="mt-1 text-sm text-red-600">{{ form.errors.password }}</div>
        </div>
        <div class="flex items-center justify-between">
          <label class="inline-flex items-center gap-2 text-sm text-gray-700">
            <input type="checkbox" v-model="form.remember" class="rounded border-gray-300 text-gray-700 focus:ring-gray-300" />
            Lembrar-me
          </label>
          <Link v-if="props.canResetPassword" :href="route('password.request')" class="text-sm text-gray-700 hover:underline">Esqueceu a senha?</Link>
        </div>
        <button
          type="submit"
          :disabled="isDisabled"
          class="w-full inline-flex items-center justify-center rounded-md bg-gray-900 px-4 py-2 text-white font-semibold shadow-sm hover:bg-gray-800 disabled:opacity-70 disabled:cursor-not-allowed"
        >
          Entrar
        </button>
      </form>

      <p class="mt-6 text-center text-sm text-gray-600">
        Não tem uma conta?
        <Link :href="route('register')" class="font-medium text-gray-700 hover:underline">Cadastre-se</Link>
      </p>
    </div>
  </div>
</template>
