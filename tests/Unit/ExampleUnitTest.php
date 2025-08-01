<?php

namespace Tests\Unit;

use Tests\TestCase;

class ExampleUnitTest extends TestCase
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
