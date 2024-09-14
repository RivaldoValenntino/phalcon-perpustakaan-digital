<?php

namespace App\Modules\Defaults\Pengembalian;

use Core\Paginator\DataTables\DataTable;
use Phalcon\Mvc\Controller as BaseController;

/**
 * @routeGroup("transaksi/pengembalian")
 */
class Controller extends BaseController
{
    /**
     * @routeGet("/")
     */
    public function indexAction() {}


    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VwPengembalian::class)
            ->orderBy('id_pengembalian DESC')
            ->where("1=1");

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
}