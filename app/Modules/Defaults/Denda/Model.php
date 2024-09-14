<?php


namespace App\Modules\Defaults\Denda;

use Phalcon\Mvc\Model as BaseModel;

class Model extends BaseModel
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('master_denda');
    }
}