<?php

namespace App\Actions\Campaigns;

use App\Models\Campaign;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class CreateNewCampaign
{
    /**
     * @param  array<string, mixed>  $input
     */
    public function create(User $user, array $input): Campaign
    {
        Validator::make($input, [
            'title' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
        ])->validate();

        return $user->campaigns()->create([
            'title' => $input['title'],
            'description' => $input['description'] ?? null,
        ]);
    }
}
