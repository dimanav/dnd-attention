<?php

namespace App\Http\Controllers;

use App\Actions\Campaigns\CreateNewCampaign;
use Illuminate\Http\Request;

class CampaignController extends Controller
{
    public function create(Request $request, CreateNewCampaign $action)
    {
        $action->create($request->user(), $request->all());

        return back();
    }
}
