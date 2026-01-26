<?php

declare(strict_types=1);

/*
 * Arch Tests
 * This test will make sure you fulfill best practices regarding functions that are still in php,
 * but probably should not be used when using Laravel.
 * And, additionally, no debugging functions in your code.
 */
arch('it fulfills security preset')
    ->preset()->security();

arch('it fulfills php preset')
    ->preset()->php();

arch('it does not use debugging')
    ->expect(['dd', 'dump', 'ddd', 'ray'])
    ->not
    ->toBeUsed();
