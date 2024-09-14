<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Referensi\Model;

use Phalcon\Mvc\Model as BaseModel;
use Core\Models\Behavior\SoftDelete;
use Phalcon\Mvc\Model\Behavior\Timestampable;

class Role extends BaseModel
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('role');
    }
}
