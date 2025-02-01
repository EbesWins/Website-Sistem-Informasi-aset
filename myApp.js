const db = require('./backend/db');
const express = require("express");
const { initDB } = require('./backend/initilizing');
const app = express();
const session = require('express-session')
const idAdmin = "LyPiw";
const bcrypt = require('bcrypt');
const { name } = require('ejs');

app.set("view engine", "ejs");
app.set("views", "views");
app.use(express.static(__dirname + '/public'));
app.use(express.json())
app.use(express.urlencoded({extended: true}));
app.use(session({ 
    secret: 'rahasia super', 
    resave: false, 
    saveUninitialized: true, 
    cookie: { 
        secure: false 
    }}
));
app.use((req, res, next) => {
     if (!req.session.role && !req.session.idUser) {
        req.session.role = 'guest'; 
        req.session.idUser = 'guest'
    }
    next();
})

function checkSession(req, res, next){
    if(req.session.role == 'guest' && req.session.idUser == 'guest'){
        return res.redirect('/')
    }
    next()
}

function checkRole(role) { 
    return function (req, res, next) { 
        if (req.session.role && req.session.role === role) {
             next(); 
        } else { 
            res.redirect("/dashboard") 
        } 
    };
}

app.get("/", async (req, res)=>{
    res.render("index", {namafile : "login"})
})

app.post("/login", async (req, res) => {
    try {
        const { username, password } = req.body;
        const rows = await db.getAksesByNama(username);
        if (rows !== false) {
            const userData = rows[0];
            bcrypt.compare(password, userData.password, function (err, result) {
                if (err) {
                    console.log(err);
                    return res.send({ message: 'Error' });
                } else if (result) {
                    console.log('Berhasil login');
                    req.session.idUser = userData.idAkses;
                    req.session.role = userData.idLevel;
                    if (userData.status === "yes") {
                        return res.sendStatus(200);
                    } else {
                        return res.sendStatus(400)
                    }
                } else {
                    return res.sendStatus(401)
                }
            });
        } else {
            return res.sendStatus(404)
        }
    } catch (error) {
        return res.sendStatus(500)
    }
});


app.get("/dashboard", checkSession, async (req, res)=>{
    res.render("index", {namafile: "dashboard"})
})

app.get("/dataMaster", checkSession, async (req, res)=>{
    const mAset = await db.getAllMasset();
    const kategori = await db.getAllKategori()
    const merk = await db.getAllMerk()
    res.render("index", {namafile: "dataMaster", data: mAset, dKategori : kategori, dMerk: merk})
})

app.post("/addAsset",checkSession, async(req, res)=>{
    const {tipe, spesifikasi, deskripsi, idKategori, idMerk} = req.body
    try {
        await db.addMasset(tipe, spesifikasi, deskripsi, idKategori, idMerk, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.put("/editAsset", checkSession, async(req, res)=>{
    const {id, tipe, spesifikasi, deskripsi, idKategori, idMerk} = req.body
    try {
        await db.updateMasset(id, tipe, spesifikasi, deskripsi, idKategori, idMerk, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.delete("/deleteAsset", checkSession, async(req, res)=>{
    const {id} = req.body
    try {
        await db.delMasset(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.post("/addLevel",checkSession, async (req, res)=>{
     try {
        const {nama} = req.body;
        await db.addLevel(nama, idUser, idUser)
        res.send({message : 'Berhasil insert'})
     } catch (e) {
        res.send({message : `${e.message}`})
     }
})

app.put("/updateLevel",checkSession, async(req, res)=>{
    try {
        const {idLevel, namaBaru} = req.body;
        await db.updateLevel(idLevel, namaBaru, idUser)
        res.send({message : 'Berhasil update'})
    } catch (e) {
        res.send({message : `${e.message}`})       
    }
})

app.get("/akun",checkSession, async (req, res)=>{
    try {
        const rows = await db.getAllAkses()
        const level = await db.getAllLevel()
        res.render("index", {namafile: "akun", data: rows, role : level})
    } catch (e) {
        res.send({message : `${e.message}`})       
    }
})

app.post("/addUser",checkSession, async(req, res)=>{
    const {nama, username, password, idLevel, status} = req.body
    try {
        const respone = await db.addAkses(nama, username, password, status, idLevel, req.session.idUser, req.session.idUser)
        if(respone == 200){
            res.send({message : 'Berhasil insert User Baru'})
        }else{
            res.send({message : 'Gagal Insert'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})       
    }
})

app.put("/updateUser",checkSession, async(req, res)=>{
    const {id, nama, username, password, status, idLevel} = req.body
    try {
        const respone = await db.updateAkses(id, nama, username, password, status, idLevel, req.session.idUser, req.session.idUser)
        if(respone == 200){
            res.send({message : 'Berhasil update user'})
        }else{
            res.send({message : 'Gagal Update'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})       
    }
})

app.get("/merk",checkSession, async(req, res)=>{
    try {
        const respone = await db.getAllMerk();
        res.render("index", {namafile: "merk", data: respone})
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.get("/merkId/:id",checkSession, async(req, res)=>{
    const id = req.params.id
    try {
        const respone = await db.getMerkId(id);
        if(respone != false){
            res.send(respone)
        }else{
            res.send({message : 'Belum ada data'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.post("/addMerk",checkSession, async(req, res)=>{
    const {nama} = req.body
    try {
        await db.addMerk(nama, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.put("/updateMerk",checkSession, async(req, res)=>{
    const {nama, id} = req.body
    try {
        const respone = await db.updateMerk(nama, req.session.idUser, id)
        if(respone == 200){
            res.send({message : 'Berhasil Insert'})
        }else{
            res.send({message : 'Ada error pada insert'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})        
    }
})

app.delete("/deleteMerk",checkSession, async (req, res)=>{
    const {id} = req.body
    try {
        await db.delMerk(id)
        res.status(200).send({message : 'Berhasil Hapus Merk'})
    } catch (e) {
        res.send({message : `${e.message}`})        
    }
})

app.get("/kategori",checkSession, async(req, res)=>{
    try {
        const respone = await db.getAllKategori();
        res.render("kategori", {namafile : "kategori", data : respone})
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.get("/kategoriId/:id",checkSession,  async(req, res)=>{
    const id = req.params.id
    try {
        const respone = await db.getKategoriId(id);
        if(respone != false){
            res.send(respone)
        }else{
            res.send({message : 'Belum ada data'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.post("/addKategori", checkSession, async(req, res)=>{
    const {nama} = req.body
    try {
        const respone = await db.addKategori(nama, req.session.idUser)
        if(respone == 200){
            res.send({message : 'Berhasil Insert'})
        }else{
            res.send({message : 'Ada error pada insert'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})
    }
})

app.put("/updateKategori", checkSession, async(req, res)=>{
    const {nama, id} = req.body
    try {
        const respone = await db.updateKategori(id, nama, req.session.idUser)
        if(respone == 200){
            res.send({message : 'Berhasil Update'})
        }else{
            res.send({message : 'Ada error pada Update'})
        }
    } catch (e) {
        res.send({message : `${e.message}`})        
    }
})

app.delete("/deleteKategori", checkSession, async(req, res)=>{
    const {id} = req.body
    try {
        await db.delKategori(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.get("/unit", checkSession, async(req, res)=>{
    const data = await db.getAllUnit()
    res.render("index", {namafile : "unit", data : data})
})

app.post("/addUnit", checkSession, async(req, res)=>{
    const {nama} = req.body;
    try {
        await db.addUnit(nama, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.put("/updateUnit", checkSession, async(req, res)=>{
    const {nama, id} = req.body
    try {
        await db.updateUnit(id, nama, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    } 
})

app.delete("/deleteUnit", checkSession, async(req, res)=>{
    const {id} = req.body
    try {
        await db.deleteUnit(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.get("/ruang", checkSession, async(req,res)=>{
    const data = await db.getAllRuang()
    const unit = await db.getAllUnit()
    res.render("index", {namafile : "ruang", data: data, unit : unit}) 
})

app.post("/addRuang", checkSession, async(req, res)=>{
    const {nama, idUnit} = req.body
    try {
        await db.addRuang(nama, idUnit, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.put("/updateRuang", checkSession, async(req, res)=>{
    const {nama, idUnit, id} = req.body
    try {
        await db.updateRuang(id, nama, idUnit, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.delete("/deleteRuang", checkSession, async(req, res)=>{
    const {id} = req.body
    try {
        await db.delRuang(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.get("/perolehan", checkSession, async(req, res)=>{
    const data = await db.getAllPerolehan()
    res.render("index", {namafile : "perolehan", data : data})
})

app.post("/addPerolehan", checkSession, async(req, res)=>{
    const {nama, keterangan} = req.body
    try {
        await db.addPerolehan(nama, keterangan, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500)
    }
})

app.put("/updatePerolehan", checkSession, async(req, res)=>{
    const {nama, keterangan, id}= req.body
    try {
        await db.updatePerolehan(id, nama, keterangan, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.delete("/deletePerolehan", checkSession, async (req, res)=>{
    const {id} = req.body
    try {
        await db.delPerolehan(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.get("/pencatatan", checkSession, async(req, res)=>{
    const data = await db.getAllPencatatan()
    const aset = await db.getAllMasset()
    const peroleh = await db.getAllPerolehan()
    res.render("index", {namafile:"pencatatan", data: data, aset : aset, peroleh : peroleh})
})

app.post("/detailPencatatan", checkSession, async(req, res)=>{
    const {idPeroleh, idAsset} = req.body
    try {
        const peroleh = await db.getPerolehanById(idPeroleh)
        const asset = await db.getMassetById(idAsset)
        res.status(200).json({"peroleh": peroleh, "asset": asset})
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.post("/addPencatatan", checkSession, async(req, res)=>{
    const {idAsset, idPerolehan, harga, tglPeroleh, keterangan, status}= req.body
    try {
        await db.addPencatatan(idAsset, idPerolehan, harga, tglPeroleh, keterangan, status, req.session.idUser)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.put("/updatePencatatan", checkSession, async(req, res)=>{
    const {idAsset, idPerolehan, harga, tglPeroleh, keterangan, status, id} = req.body
    try {
        await db.updatePencatatan(idAsset, idPerolehan, harga, tglPeroleh, keterangan, status, req.session.idUser, id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.delete("/deletePencatatan", checkSession, async(req, res)=>{
    const {id}= req.body
    try {
        await db.delPencatatan(id)
        res.sendStatus(200)
    } catch (e) {
        res.sendStatus(500) 
    }
})

app.get("/riwayat", checkSession, async(req, res)=>{
    const data = await db.getAllRiwayat()
    res.render("index", {namafile : "riwayat", data: data})
    console.log(data)
})

app.post("/detailRiwayat", checkSession, async(req, res)=>{
    const {idPeroleh, idRuang} = req.body
    try {
        const peroleh = await db.getPerolehanById(idPeroleh)
        const ruang = await db.getRuangById(idRuang)
        res.status(200).json({"peroleh": peroleh, "ruang": ruang})
    } catch (e) {
        res.status(500)
    }
})

app.put("/editRiwayat", checkSession, async(req, res)=>{
    const {id, idPencatatan, tglAudit, kondisi, idRuang} = req.body
    try {
        await db.editRiwayat(id, idPencatatan, tglAudit, kondisi, idRuang, req.session.idUser)
        res.status(200).json({message : 'Berhasil Update data'})
    } catch (e) {
        res.status(500)
    }
})

app.delete("/deleteRiwayat", checkSession, async(req, res)=>{
    const {id} = req.body
    try {
        await db.delRiwayatId(id)
        res.status(200).json({message : 'Berhasil delete data'})
    } catch (e) {
        res.status(500)
    }
})

app.post("/addRiwayat", checkSession, async(req, res)=>{
    const {idPencatatan, idRuang, kondisi, tglAudit} = req.body
    try {
        await db.addRiwayat(idPencatatan, idRuang, kondisi, tglAudit, req.session.idUser)
        res.status(200).json({message : 'Berhasil add data'})
    } catch (e) {
        res.status(500)
    }
})

// const PORT = process.env.PORT || 3333;
app.listen(3333, () => {
    console.log("Web running : " + 3333);
})  


