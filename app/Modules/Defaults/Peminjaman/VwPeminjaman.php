<?php

namespace App\Modules\Defaults\Peminjaman;

use Phalcon\Mvc\Model;

class VwPeminjaman extends Model
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('vw_master_peminjaman');
    }
}