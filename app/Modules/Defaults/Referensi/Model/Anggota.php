<?php

namespace App\Modules\Defaults\Referensi\Model;

use Phalcon\Mvc\Model;

class Anggota extends Model
{
    public function initialize()
    {
        $this->setConnectionService('db');
        $this->setSource('master_anggota');
    }
}