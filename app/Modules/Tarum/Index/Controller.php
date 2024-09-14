<?php

declare(strict_types=1);

namespace App\Modules\Tarum\Index;

use Phalcon\Mvc\Controller as BaseController;
use Core\Facades\Response;
use Core\Facades\Session;

class Controller extends BaseController
{
    /**
     * @routeGet("/")
     */
    public function indexAction() {}
}