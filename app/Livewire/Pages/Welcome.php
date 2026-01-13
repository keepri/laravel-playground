<?php

declare(strict_types=1);

namespace App\Livewire\Pages;

use Illuminate\Contracts\View\View;
use Livewire\Attributes\Layout;
use Livewire\Component;

#[Layout('layouts.app')]
class Welcome extends Component
{
    public int $initial = 0;

    public function mount(int $initial = 8): void
    {
        $this->initial = $initial;
    }

    public function render(): View
    {
        return view('livewire.pages.welcome');
    }
}
