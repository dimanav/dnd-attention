<script setup lang="ts">
import { ref } from 'vue';
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { router } from '@inertiajs/vue3';
import { create as campaignsCreate } from '@/actions/App/Http/Controllers/CampaignController';

const open = defineModel<boolean>('open', { default: false });

const title = ref('');
const description = ref('');

function onCreate() {
    router.post(campaignsCreate().url, {
        title: title.value,
        description: description.value,
    },
    {
        onSuccess: () => {
            title.value = '';
            description.value = '';
            open.value = false;
        },
    });
}
</script>

<template>
    <Dialog v-model:open="open">
        <DialogContent class="sm:max-w-[425px]">
            <DialogHeader>
                <DialogTitle>Создайте кампанию</DialogTitle>
                <DialogDescription>
                    Начните новое приключение
                </DialogDescription>
            </DialogHeader>
            <div class="grid gap-4 py-4">
                <div class="grid gap-2">
                    <Label for="campaign-name">Название</Label>
                    <Input
                        id="campaign-name"
                        v-model="title"
                    />
                </div>
                <div class="grid gap-2">
                    <Label for="campaign-description">Описание (не обязательно)</Label>
                    <Input
                        id="campaign-description"
                        v-model="description"
                    />
                </div>
            </div>
            <DialogFooter>
                <Button variant="outline" @click="open = false">
                    Отмена
                </Button>
                <Button :disabled="!title.trim()" @click="onCreate">
                    Создать
                </Button>
            </DialogFooter>
        </DialogContent>
    </Dialog>
</template>
