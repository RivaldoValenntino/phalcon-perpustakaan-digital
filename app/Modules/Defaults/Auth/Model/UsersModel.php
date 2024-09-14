<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Auth\Model;

use Phalcon\Mvc\Model;
use Core\Models\Behavior\SoftDelete;
use Phalcon\Mvc\Model\Behavior\Timestampable;
use App\Modules\Defaults\Auth\Model\RolesModel;
use App\Modules\Defaults\ModelStandAlone\CabangModel;

class UsersModel extends Model
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('user');
    }
}
