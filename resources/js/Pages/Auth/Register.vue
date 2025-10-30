<script setup>
import { useForm, Link } from '@inertiajs/vue3';
import { computed } from 'vue';
import { UserIcon, EnvelopeIcon, LockClosedIcon } from '@heroicons/vue/24/outline';

const form = useForm({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
});

const isDisabled = computed(() => form.processing);

function submit() {
  form.post(route('register'));
}
</script>

<template>
  <div class="min-h-screen bg-gray-50 flex items-center justify-center px-4">
    <div class="w-full max-w-md bg-white rounded-lg shadow-md p-6 border border-gray-200">
      <h1 class="text-2xl font-bold text-center text-gray-900">Criar conta</h1>
      <form class="mt-6 space-y-5" @submit.prevent="submit">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700">Nome</label>
          <div class="relative mt-1">
            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
              <UserIcon class="h-5 w-5 text-gray-400" />
            </span>
            <input
              id="name"
              type="text"
              v-model="form.name"
              required
              autocomplete="name"
              class="block w-full rounded-md border border-gray-300 bg-white pl-10 pr-3 py-1.5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-gray-200"
              placeholder="Seu nome"
            />
          </div>
          <div v-if="form.errors.name" class="mt-1 text-sm text-red-600">{{ form.errors.name }}</div>
        </div>
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
              autocomplete="new-password"
              class="block w-full rounded-md border border-gray-300 bg-white pl-10 pr-3 py-1.5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-gray-200"
              placeholder="••••••••"
            />
          </div>
          <div v-if="form.errors.password" class="mt-1 text-sm text-red-600">{{ form.errors.password }}</div>
        </div>
        <div>
          <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmar senha</label>
          <div class="relative mt-1">
            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
              <LockClosedIcon class="h-5 w-5 text-gray-400" />
            </span>
            <input
              id="password_confirmation"
              type="password"
              v-model="form.password_confirmation"
              required
              autocomplete="new-password"
              class="block w-full rounded-md border border-gray-300 bg-white pl-10 pr-3 py-1.5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-gray-200"
              placeholder="••••••••"
            />
          </div>
        </div>
        <button
          type="submit"
          :disabled="isDisabled"
          class="w-full inline-flex items-center justify-center rounded-md bg-gray-900 px-4 py-2 text-white font-semibold shadow-sm hover:bg-gray-800 disabled:opacity-70 disabled:cursor-not-allowed"
        >
          Criar conta
        </button>
      </form>
      <p class="mt-6 text-center text-sm text-gray-600">
        Já tem conta?
        <Link :href="route('login')" class="font-medium text-gray-700 hover:underline">Entrar</Link>
      </p>
    </div>
  </div>
</template>
