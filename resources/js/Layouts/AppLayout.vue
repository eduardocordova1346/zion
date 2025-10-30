<script setup>
import { Link, usePage } from '@inertiajs/vue3';
import { computed } from 'vue';
import { HomeIcon, UserIcon, ArrowRightOnRectangleIcon, ChevronDownIcon, MagnifyingGlassIcon } from '@heroicons/vue/24/outline';
import { ref } from 'vue';

const page = usePage();
const user = computed(() => page.props.auth?.user ?? null);
const appName = computed(() => page.props.app?.name ?? '');
const showAccount = ref(false);
const initials = computed(() => {
  const name = user.value?.name ?? '';
  if (!name) return 'ZI';
  return name
    .trim()
    .split(/\s+/)
    .map((w) => w[0])
    .slice(0, 2)
    .join('')
    .toUpperCase();
});
</script>
<template>
  <div class="min-h-screen flex bg-gray-50">
    <aside class="w-64 shrink-0 border-r border-gray-200 bg-white relative">
      <div class="h-14 flex items-center justify-center px-4 border-b border-gray-200">
        <span class="text-base font-bold text-gray-900">{{ appName }}</span>
      </div>
      <nav class="p-4 space-y-2">
        <div class="mb-2">
          <div class="relative">
            <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
              <MagnifyingGlassIcon class="h-4 w-4 text-gray-400" />
            </span>
            <input type="text" placeholder="Buscar" class="w-full rounded-md border border-gray-300 bg-white pl-8 pr-3 py-2 text-sm text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-200" />
          </div>
        </div>
        <Link href="/app" class="flex items-center gap-3 px-3 py-2 rounded-md text-gray-700 hover:bg-gray-100">
          <HomeIcon class="h-5 w-5" />
          <span>Início</span>
        </Link>
        <button type="button" @click="showAccount = !showAccount" class="w-full flex items-center justify-between px-3 py-2 rounded-md text-gray-700 hover:bg-gray-100">
          <span class="inline-flex items-center gap-3">
            <UserIcon class="h-5 w-5" />
            <span>Conta</span>
          </span>
          <ChevronDownIcon class="h-4 w-4 text-gray-500" :class="{ 'rotate-180': showAccount }" />
        </button>
        <div v-show="showAccount" class="ml-8 space-y-1">
          <Link :href="route('account.profile')" class="block px-3 py-2 rounded-md text-gray-700 hover:bg-gray-100">Alterar dados</Link>
          <Link :href="route('account.password')" class="block px-3 py-2 rounded-md text-gray-700 hover:bg-gray-100">Alterar senha</Link>
        </div>
        <Link :href="route('logout')" method="post" as="button" class="mt-2 w-full inline-flex items-center justify-center gap-2 rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 hover:bg-gray-50">
          <ArrowRightOnRectangleIcon class="h-5 w-5" />
          <span>Sair</span>
        </Link>
        <div class="mt-4 h-px bg-gray-200"></div>
      </nav>
      <div class="absolute bottom-0 left-0 right-0 p-4">
        <div class="flex items-center justify-between rounded-xl border border-gray-200 bg-white p-3 shadow-sm overflow-hidden">
          <div class="flex items-center gap-3">
            <div class="relative h-9 w-9 rounded-lg bg-gray-100 text-gray-700 flex items-center justify-center text-sm font-bold">
              {{ initials }}
              <span class="absolute -bottom-0.5 -right-0.5 h-2.5 w-2.5 rounded-full bg-green-500 ring-2 ring-white"></span>
            </div>
            <div>
              <p class="text-sm font-semibold text-gray-900 truncate max-w-[10rem]">{{ user?.name }}</p>
              <p class="text-xs text-gray-500 truncate max-w-[10rem]">{{ user?.email }}</p>
            </div>
          </div>
        </div>
      </div>
    </aside>
    <main class="flex-1">
      <slot />
    </main>
  </div>
</template>
