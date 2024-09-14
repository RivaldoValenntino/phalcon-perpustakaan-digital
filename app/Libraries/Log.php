<?php

namespace App\Libraries;

use App\Models\LogModel;
use Core\Facades\DB;

class Log
{
    protected $requireAuth = true;

    public static function write($message, $data = NULL, $result = NULL, $controller = "", $action = "")
    {
        $session    = \Phalcon\Di::getDefault()->getShared('session');
        $request    = \Phalcon\Di::getDefault()->getShared('request');
        $session    = (object) $session->get('user');
        $ip         = (object) $request->getClientAddress();
        $url        = (object) $request->getURI();
        DB::insert(
            'log_akses',
            array(
                $session->id,
                $session->username,
                $session->nama,
                $ip->scalar,
                $_SERVER['SERVER_NAME'] . $url->scalar,
                $message,
                json_encode($data),
                json_encode($result),
                $controller,
                $action,
            ),
            array(
                "id_user",
                "username",
                "name",
                "ip",
                "url",
                "message",
                "data",
                "response",
                "controller",
                "action",
            )
        );
    }
}
