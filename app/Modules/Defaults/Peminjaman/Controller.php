<?php

namespace App\Modules\Defaults\Peminjaman;

use Phalcon\Mvc\Controller as BaseController;
use Core\Facades\Response;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Master\Buku\Model as Buku;
use App\Modules\Defaults\Peminjaman\Model as Peminjaman;

/**
 * @routeGroup("transaksi/peminjaman")
 */
class Controller extends BaseController
{

    /**
     * @routeGet("/")
     */
    public function indexAction() {}


    /**
     * @routeGet("/datatableBuku")
     * @routePost("/datatableBuku")
     */
    public function datatableBukuAction()
    {
        $searchBuku = Request::getPost('searchBuku');
        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(Buku::class)
            ->orderBy('id DESC')
            ->where("1=1");
        if (isset($searchBuku) && !empty($searchBuku)) {
            $builder->andWhere("judul LIKE '%$searchBuku%'"
                . " OR kode_buku LIKE '%$searchBuku%'");
        }
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VwPeminjaman::class)
            ->orderBy('id DESC')
            ->where("1=1")
            ->andWhere("status_peminjaman = 'dipinjam'");

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }


    /**
     * @routeGet("/create")
     */
    public function createAction() {}

    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        $id_anggota = Request::getPost('id_anggota');
        $idBukuArray = Request::getPost('id_buku');
        $tanggalPinjam = $this->request->getPost('tanggal_pinjam');
        $tanggalKembali = $this->request->getPost('tanggal_kembali');
        $keterangan = $this->request->getPost('keterangan');


        if (!empty($idBukuArray)) {
            foreach ($idBukuArray as $idBuku) {
                $peminjaman = new Peminjaman();
                $peminjaman->id_buku = $idBuku;
                $peminjaman->id_anggota = $id_anggota;
                $peminjaman->tanggal_pinjam = $tanggalPinjam;
                $peminjaman->tanggal_kembali = $tanggalKembali;
                $peminjaman->keterangan = $keterangan;
                $peminjaman->tanggal_dibuat = date('Y-m-d H:i:s');
                $peminjaman->kode_peminjaman = 'PJM' . date('YmdHis');
                if (!$peminjaman->save()) {
                    foreach ($peminjaman->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                }

                $buku = Buku::findFirstById($idBuku);
                $buku->status = 'dipinjam';
                $buku->save();
            }

            return Response::setJsonContent([
                'message' => 'Success',
                'error'   => 0
            ]);
        } else {
            return Response::setJsonContent([
                'message' => 'Pilih buku terlebih dahulu',
                'error'   => 1
            ]);
        }
    }
    /**
     * @routePost("/kembalikan")
     */
    public function kembalikanAction()
    {
        $id = Request::get('id');
        $data = Model::findFirst($id);
        $data->status = 'dikembalikan';
        $data->save();
        $buku = Buku::findFirstById($data->id_buku);
        $buku->status = 'tersedia';
        $buku->save();
        $pengembalian = new ModelPengembalian();
        $pengembalian->id_peminjaman = $data->id;
        $pengembalian->tanggal_pinjam = $data->tanggal_pinjam;
        $pengembalian->tanggal_kembali = $data->tanggal_kembali;
        $pengembalian->kode_pengembalian = 'PNG' . date('YmdHis');
        $pengembalian->save();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
}