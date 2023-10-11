// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PengelolaanLimbah {
    address public admin;


    struct Sampah {
        uint256 id;
        string deskripsi;
        uint256 jumlah;
    }

    Sampah[] public sampahs;

    event SampahDitambahkan(uint256 id, string deskripsi, uint256 jumlah);
    event SampahDihapus(uint256 id);

    // Modifikasi untuk memeriksa apakah pemanggil adalah admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Hanya admin yang dapat mengakses fungsi ini");
        _;
    }


    // Constructor akan dipanggil saat kontrak dibuat
    constructor() {
        admin = msg.sender;
    }


    // Fungsi untuk mengatur alamat admin
    function setAdmin(address newAdmin) public onlyAdmin {
        require(newAdmin != address(0), "Alamat admin baru tidak valid");
        admin = newAdmin;
    }

    function tambahSampah(uint256 _id, string memory _deskripsi, uint256 _jumlah) public onlyAdmin {
    require(_id >= sampahs.length, "ID sampah sudah digunakan");
    sampahs.push(Sampah(_id, _deskripsi, _jumlah));
    emit SampahDitambahkan(_id, _deskripsi, _jumlah);
   }


    function hapusSampah(uint256 _id) public onlyAdmin {
        require(_id < sampahs.length, "ID sampah tidak valid");
        delete sampahs[_id];
        emit SampahDihapus(_id);
    }

    function getSampahById(uint256 _id) public view returns (uint256, string memory, uint256) {
    require(_id < sampahs.length, "ID sampah tidak valid");
    Sampah memory sampah = sampahs[_id];
    return (sampah.id, sampah.deskripsi, sampah.jumlah);
    }

}
