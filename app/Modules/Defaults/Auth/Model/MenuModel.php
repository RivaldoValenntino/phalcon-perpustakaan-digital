<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Auth\Model;

use Core\Facades\DB;
use Phalcon\Mvc\Model;
use Core\Models\Behavior\SoftDelete;
use PDO;
use Phalcon\Mvc\Model\Behavior\Timestampable;

class MenuModel extends Model
{
    public function initialize()
    {
        $this->setSource('menu');

        $this->hasMany('id_menu', MenuModel::class, 'id_menu_parent', [
            'alias' => 'children',
            'reusable' => true
        ]);
    }

    public static function getUserMenuList()
    {
        $di      = \Phalcon\Di::getDefault();
        $session = $di->getShared('session');
        $db      = $di->getShared('db');
        $sql = "
            SELECT * 
            FROM menu 
            WHERE 1=1 
                AND id_menu in (SELECT id_menu FROM menu_otorisasi where id_role=? ) ORDER by urutan;
        ";

        $result = DB::query($sql, [$session->user['id_role']])->fetchAll(PDO::FETCH_OBJ);
        return self::toTree($result);
    }

    private static function toTree($flatMenu, $idParent = 0)
    {
        $menus = [];
        foreach ($flatMenu as $key => $item) {
            if ($item->parent_menu == $idParent) {
                unset($flatMenu[$key]);
                $children = self::toTree($flatMenu, $item->id_menu);
                $item->has_children = !empty($children);
                $item->children = (array) $children;
                $menus[] = $item;
            }
        }

        return $menus;
    }
}