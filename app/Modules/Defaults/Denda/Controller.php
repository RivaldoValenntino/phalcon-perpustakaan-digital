<?php

namespace App\Modules\Defaults\Denda;

use Core\Paginator\DataTables\DataTable;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Denda\Model as Denda;
use Core\Facades\Request;
use Core\Facades\Response;

/**
 * @routeGroup("sanksi-denda")
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
            ->from(Denda::class)
            ->orderBy('id DESC')
            ->where("1=1");

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        $sessUser = $this->session->user['nama'];
        $data = [
            'nama'          => Request::getPost('nama'),
            'jumlah_denda'  => Request::getPost('jumlah_denda'),
            'tanggal_dibuat' => date('Y-m-d H:i:s'),
        ];
        $create = new Denda($data);
        $create->save();
        return Response::setJsonContent([
            'message' => 'Success',
            'error'   => 0,
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
            'jumlah_denda'  => Request::getPost('jumlah_denda'),
            'tanggal_diubah' => date('Y-m-d H:i:s'),
        ];

        $update = Denda::findFirst($id);
        $update->assign($data);
        $update->save();
        return Response::setJsonContent([
            'message' => 'Success',
            'error'   => 0,
        ]);
    }

    /**
     * @routePost("/delete")
     */
    public function deleteAction()
    {
        $id = Request::get('id');
        $delete = Denda::findFirst($id);
        $delete->delete();
        return Response::setJsonContent([
            'message' => 'Success',
            'error'   => 0,
        ]);
    }
}