<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Master\Buku;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use Core\Facades\Response;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;

/**
 * @routeGroup("/master/data-buku")
 */
class Controller extends BaseController
{
    /**
     * @routeGet("/")
     */
    public function indexAction()
    {
        // var_dump($id);
        // die();
        // $this->view->setVar('module', $id);
    }

    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        $search_judul = Request::getPost('search_judul');
        $search_kategori = Request::getPost('search_kategori');
        $search_penerbit = Request::getPost('search_penerbit');
        $search_penulis = Request::getPost('search_penulis');
        $search_tahun = Request::getPost('search_tahun');
        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(Model::class)
            ->orderBy('id DESC')
            ->where("1=1");
        if (isset($search_judul) && !empty($search_judul)) {
            $builder->andWhere("judul LIKE '%$search_judul%'");
        }
        if (isset($search_penerbit) && !empty($search_penerbit)) {
            $builder->andWhere("penerbit = '%$search_penerbit%'");
        }
        if (isset($search_penulis) && !empty($search_penulis)) {
            $builder->andWhere("penulis = '%$search_penulis%'");
        }
        if (isset($search_kategori) && !empty($search_kategori)) {
            $builder->andWhere("kategori = '$search_kategori'");
        }
        if (isset($search_tahun) && !empty($search_tahun)) {
            $builder->andWhere("tahun_terbit = '$search_tahun'");
        }
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }

    /**
     * @routeGet("/detail")
     */
    public function detailAction() {}

    /**
     * @routeGet("/create")
     */
    public function createAction() {}

    /**
     * @routePost('/UploadFile')
     */
    public function UploadFileAction()
    {
        $oldFile = $this->request->getPost('old_file');

        if ($oldFile && file_exists(BASEPATH . '/public/cover/' . $oldFile)) {
            unlink(BASEPATH . '/public/cover/' . $oldFile);
        }

        if ($this->request->hasFiles(true)) {
            $file = $this->request->getUploadedFiles()[0];
            $fileType = $file->getType();
            $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];

            if (!in_array($fileType, $allowedTypes)) {
                return $this->response->setJsonContent([
                    'status' => 0,
                    'message' => 'Tipe file tidak diizinkan hanya JPEG, PNG, dan JPG',
                ]);
            }

            $uploadDir = BASEPATH . '/public/cover/';
            $jenis = $this->determineFileType($fileType);
            $filename = $this->generateFileName($file->getName());

            if ($file->isUploadedFile()) {
                $file->moveTo($uploadDir . $filename);
                $response = [
                    'status' => 1,
                    'filename' => $filename,
                    'name' => pathinfo($file->getName(), PATHINFO_FILENAME),
                    'jenis' => $jenis,
                ];

                return $this->response->setJsonContent($response);
            }
        }

        return $this->response->setJsonContent(['status' => 0]);
    }
    /**
     * Menentukan jenis file berdasarkan tipe.
     *
     * @param string $fileType
     * @return string
     */
    private function determineFileType($fileType)
    {
        if (strpos($fileType, 'image') !== false) {
            return 'image';
        } elseif (strpos($fileType, 'video') !== false) {
            return 'video';
        } else {
            return 'document';
        }
    }


    /**
     * Menghasilkan nama file baru berdasarkan tanggal dan waktu saat ini.
     *
     * @param string $originalName
     * @return string
     */
    private function generateFileName($originalName)
    {
        $extension = pathinfo($originalName, PATHINFO_EXTENSION);
        $date = date('Ymd') . '-' . time();
        return $date . '.' . $extension;
    }
    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        // Ambil data dari form
        $judul = $this->request->getPost('judul');
        $penulis = $this->request->getPost('penulis');
        $penerbit = $this->request->getPost('penerbit');
        $tahun_terbit = $this->request->getPost('tahun_terbit');
        $kategori = $this->request->getPost('kategori');
        $keterangan = $this->request->getPost('keterangan');
        $nama_cover = json_decode($this->request->getPost('nama_cover'), true)['file_name'];
        $jumlah = (int) $this->request->getPost('stok');

        for ($i = 1; $i <= $jumlah; $i++) {
            $kode_buku = 'BKPG' . strtoupper(substr($judul, 0, 6)) . str_pad(
                (string)$i,
                3,
                '0',
                STR_PAD_LEFT
            );


            $data = [
                'judul' => $judul,
                'penulis' => $penulis,
                'penerbit' => $penerbit,
                'tahun_terbit' => $tahun_terbit,
                'kategori' => $kategori,
                'keterangan' => $keterangan,
                'kode_buku' => $kode_buku,
                'cover' => $nama_cover,
                'tanggal_dibuat' => date('Y-m-d H:i:s'),
                'tanggal_diubah' => date('Y-m-d H:i:s')
            ];

            $create = new Model($data);
            if (!$create->save()) {
                return Response::setJsonContent([
                    'message' => 'Error saving book: ' . implode(', ', $create->getMessages()),
                    'error'   => 1
                ]);
            }
        }

        // Jika semua data tersimpan, kirim respon sukses
        return Response::setJsonContent([
            'message' => 'Success, ' . $jumlah . ' books added!',
            'error'   => 0
        ]);
    }

    /**
     * @routeGet("/edit/{id}")
     */
    public function editAction($id)
    {
        $data = Model::findFirst($id)->toArray();
        $penulis  = $data['penulis'];
        $penerbit = $data['penerbit'];
        $kategori = $data['kategori'];
        // var_dump($data);
        // die();
        $this->view->dataId = $id;
        $this->view->NamaKategori = $kategori;
        $this->view->NamaPenulis = $penulis;
        $this->view->NamaPenerbit = $penerbit;
        $this->view->coverImageUrl =  'cover/' . $data['cover'];
        $this->view->dataBuku = $data;
    }

    /**
     * @routePost("/update")
     */
    public function updateAction()
    {
        $id = Request::getPost('id');
        $nama_cover = json_decode($this->request->getPost('nama_cover'), true);

        $existingData = Model::findFirst($id);

        if (!$existingData) {
            return Response::setJsonContent([
                'message' => 'Record not found',
                'error'   => 1
            ]);
        }

        $oldCover = $existingData->cover;

        $data = [
            'judul' => Request::getPost('judul'),
            'penulis' => Request::getPost('penulis'),
            'penerbit' => Request::getPost('penerbit'),
            'tahun_terbit' => Request::getPost('tahun_terbit'),
            'kategori' => Request::getPost('kategori'),
            'stok' => Request::getPost('stok'),
            'keterangan' => Request::getPost('keterangan'),
            'tanggal_dibuat' => date('Y-m-d H:i:s'),
        ];

        if ($nama_cover && isset($nama_cover['file_name'])) {
            $data['cover'] = $nama_cover['file_name'];

            if ($oldCover && file_exists(BASEPATH . '/public/cover/' . $oldCover)) {
                unlink(BASEPATH . '/public/cover/' . $oldCover);
            }
        } else {
            $data['cover'] = $oldCover;
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
        $delete = Model::findFirst($id);
        if ($delete->cover && file_exists(BASEPATH . '/public/cover/' . $delete->cover)) {
            unlink(BASEPATH . '/public/cover/' . $delete->cover);
        }
        $delete->delete();
        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
}