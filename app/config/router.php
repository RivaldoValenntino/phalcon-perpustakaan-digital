<?php

return [

    /**
     * Allow reading route definition from controller annotation
     */
    'annotationRoute' => [
        'enabled'       => true,
        'namespace'     => 'App\\Modules',
        'directory'     => APP_PATH . '/Modules',
        'isModular'     => true,
        'defaultModule' => 'Defaults',
        'modules'       => [
            'Panel'     => 'panel',
            'Tarum'     => 'tarum',
        ],
    ],

    /**
     * Route loaded in folder app/routes
     */
    'routes' => ['main'],
];