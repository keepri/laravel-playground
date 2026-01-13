<?php

declare(strict_types=1);

namespace App\Livewire\Pages;

use Livewire\Component;

class Welcome extends Component
{
    public int $initial = 5;

    public function mount(int $initial = 5): void
    {
        $this->initial = $initial;
    }

    public function render(): \Illuminate\Contracts\View\View
    {
        return view('livewire.pages.welcome');
    }
}

