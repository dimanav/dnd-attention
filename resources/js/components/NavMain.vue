<script setup lang="ts">
import { ref } from 'vue';
import { Link } from '@inertiajs/vue3';
import {
    SidebarGroup,
    SidebarGroupLabel,
    SidebarMenu,
    SidebarMenuButton,
    SidebarMenuItem,
} from '@/components/ui/sidebar';
import CreateCampaignDialog from '@/components/CreateCampaignDialog.vue';
import { useCurrentUrl } from '@/composables/useCurrentUrl';
import type { NavItem } from '@/types';

defineProps<{
    items: NavItem[];
}>();

const { isCurrentUrl } = useCurrentUrl();
const showDialog = ref(false);
</script>

<template>
    <SidebarGroup class="px-2 py-0">
        <SidebarMenu>
            <SidebarMenuItem>
                <SidebarMenuButton @click="showDialog = true">
                    <span>Создать кампанию</span>
                </SidebarMenuButton>
            </SidebarMenuItem>
        </SidebarMenu>
        <SidebarGroupLabel>Веду</SidebarGroupLabel>
        <SidebarMenu>
            <SidebarMenuItem v-for="item in items" :key="item.title">
                <SidebarMenuButton
                    as-child
                    :is-active="isCurrentUrl(item.href)"
                    :tooltip="item.title"
                >
                    <Link :href="item.href">
                        <component :is="item.icon" />
                        <span>{{ item.title }}</span>
                    </Link>
                </SidebarMenuButton>
            </SidebarMenuItem>
        </SidebarMenu>
        <SidebarGroupLabel>Участвую</SidebarGroupLabel>
        <SidebarMenu>
            <SidebarMenuItem v-for="item in items" :key="item.title">
                <SidebarMenuButton
                    as-child
                    :is-active="isCurrentUrl(item.href)"
                    :tooltip="item.title"
                >
                    <Link :href="item.href">
                        <component :is="item.icon" />
                        <span>{{ item.title }}</span>
                    </Link>
                </SidebarMenuButton>
            </SidebarMenuItem>
        </SidebarMenu>
    </SidebarGroup>

    <CreateCampaignDialog v-model:open="showDialog" />
</template>
