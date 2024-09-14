<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Master\Penerbit;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Master\Penerbit\Model as Penerbit;

/**
 * @routeGroup("/master/data-penerbit")
 */
class Controller extends BaseController
{
    /**
     * @routeGet("/")
     */
    public function indexAction($id)
    {
        // var_dump($id);
        // die();
        $this->view->setVar('module', $id);
    }

    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        $search_nama = Request::getPost('search_nama');

        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(Penerbit::class)
            ->orderBy('id DESC')
            ->where("1=1");

        if ($search_nama) {
            $builder->andWhere("nama LIKE '%$search_nama%'");
        }
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }

    /**
     * @routeGet("/detail")
     */
    public function detailAction() {}

    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        $sessUser = $this->session->user['nama'];
        $data = [
            'nama'          => Request::getPost('nama'),
            'created_at'    => date('Y-m-d H:i:s'),
            'created_by'    => $sessUser,
        ];
        $create = new Penerbit($data);
        $create->save();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }

    /**
     * @routePost("/update")
     */
    public function updateAction()
    {
        $id = Request::getPost('id');
        $data = [
            'nama'          => Request::getPost('nama'),
            'updated_at'    => date('Y-m-d H:i:s'),
        ];

        $update = Penerbit::findFirst($id);
        $update->assign($data);
        $update->save();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }

    /**
     * @routePost("/delete")
     */
    public function deleteAction()
    {
        $id = Request::get('id');
        $delete = Penerbit::findFirst($id);
        $delete->delete();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
}