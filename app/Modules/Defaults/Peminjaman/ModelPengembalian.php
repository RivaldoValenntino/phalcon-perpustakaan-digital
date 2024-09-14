<?php

namespace App\Modules\Defaults\Peminjaman;

use Phalcon\Mvc\Model as BaseModel;

class ModelPengembalian extends BaseModel
{

    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('master_pengembalian');
    }
}