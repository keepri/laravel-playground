<?php

declare(strict_types=1);

namespace Tests\Unit;

use Tests\TestCase;

class ExampleFeatureTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function test_basic_test(): void
    {
        $this->get('/')
            ->assertStatus(200);
    }
}
