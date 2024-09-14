<?php

namespace App\Modules\Defaults\Pengembalian;

use Phalcon\Mvc\Model;

class VwPengembalian extends Model
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('vw_master_pengembalian');
    }
}