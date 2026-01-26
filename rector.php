<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use RectorLaravel\Rector\MethodCall\ResponseHelperCallToJsonResponseRector;
use RectorLaravel\Set\LaravelSetList;
use RectorLaravel\Set\LaravelSetProvider;

return RectorConfig::configure()
    ->withPaths([
        __DIR__ . '/app',
        __DIR__ . '/routes',
        __DIR__ . '/bootstrap',
        __DIR__ . '/config',
        __DIR__ . '/database',
        __DIR__ . '/resources',
        __DIR__ . '/routes',
        __DIR__ . '/tests',
    ])
    ->withRootFiles()
    ->withSkip([
        __DIR__ . '/vendor',
        __DIR__ . '/node_modules',
        __DIR__ . '/storage',
        __DIR__ . '/bootstrap/cache',
    ])
    ->withSetProviders(LaravelSetProvider::class)
    ->withComposerBased(laravel: true/** other options */)
//    ->withConfiguredRule(RemoveDumpDataDeadCodeRector::class, [
//        'dd', 'dump', 'var_dump'
//    ])
    ->withRules([ResponseHelperCallToJsonResponseRector::class])
    ->withPhpSets()
    ->withPreparedSets(
        deadCode: true,
        codeQuality: true,
        earlyReturn: true,
    )
    ->withSets([
        LaravelSetList::LARAVEL_CODE_QUALITY,
        LaravelSetList::LARAVEL_COLLECTION,
        LaravelSetList::LARAVEL_ARRAY_STR_FUNCTION_TO_STATIC_CALL,
        LaravelSetList::LARAVEL_ELOQUENT_MAGIC_METHOD_TO_QUERY_BUILDER,
        LaravelSetList::LARAVEL_IF_HELPERS,
        //        LaravelSetList::LARAVEL_STATIC_TO_INJECTION,
        LaravelSetList::LARAVEL_TYPE_DECLARATIONS,
    ]);
