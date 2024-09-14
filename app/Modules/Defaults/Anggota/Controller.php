<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Anggota;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use Core\Facades\Response;
use Core\Facades\Request;
use App\Modules\Defaults\Anggota\Model as Anggota;
use Core\Paginator\DataTables\DataTable;

/**
 * @routeGroup("/daftar-anggota")
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
        $search_nama = Request::getPost('search_nama');
        $search_email = Request::getPost('search_email');
        $search_telepon = Request::getPost('search_telepon');
        $search_alamat = Request::getPost('search_alamat');
        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(Anggota::class)
            ->orderBy('id DESC')
            ->where("1=1");
        if (isset($search_nama) && !empty($search_nama)) {
            $builder->andWhere("nama LIKE '%$search_nama%'");
        }
        if (isset($search_email) && !empty($search_email)) {
            $builder->andWhere("email LIKE '%$search_email%'");
        }
        if (isset($search_telepon) && !empty($search_telepon)) {
            $builder->andWhere("telepon LIKE '%$search_telepon%'");
        }
        if (isset($search_alamat) && !empty($search_alamat)) {
            $builder->andWhere("alamat LIKE '%$search_alamat%'");
        }

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }


    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        $data = [
            'nama'          => Request::getPost('nama'),
            'email'         => Request::getPost('email'),
            'kode_anggota'  => 'ANG' . date('YmdHis'),
            'telepon'       => Request::getPost('telepon'),
            'alamat'        => Request::getPost('alamat'),
            'tanggal_dibuat' => date('Y-m-d H:i:s'),
        ];

        $create = new Anggota($data);
        $create->save();

        return Response::setJsonContent([
            'message' => 'Success',
            'error'   => 0
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
            'email'         => Request::getPost('email'),
            'telepon'       => Request::getPost('telepon'),
            'alamat'        => Request::getPost('alamat'),
            'tanggal_dibuat' => date('Y-m-d H:i:s'),
        ];

        $existingData = Anggota::findFirst($id);

        if (!$existingData) {
            return Response::setJsonContent([
                'message' => 'Data not found',
                'error'   => 1
            ]);
        }


        $existingData->assign($data);
        $existingData->save();

        return Response::setJsonContent([
            'message' => 'Success',
            'error'   => 0
        ]);
    }


    /**
     * @routePost("/delete")
     */
    public function deleteAction()
    {
        $id = Request::get('id');
        $delete = Anggota::findFirst($id);
        $delete->delete();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
}