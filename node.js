
const express = require('express');
const mysql = require('mysql');
const app = express();
const bodyParser = require('body-parser');


app.use(bodyParser.json());

// Add headers
app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', true);

    // Pass to next layer of middleware
    next();
});



//connection
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Passw0rd",
    database: "villagepeopledb",
});

//test connection
db.connect((err)=> {
    if(err){
        throw err;
    }

    console.log('Connected...');
})



//listen port
app.listen('3307', () => {
    console.log('server started on port 3307');
});

//haetaan kaikki asiakkaat


app.get('/kaikkiasiakkaat', (reg, res) => {

    let post = {title:'asiakas', body: "asiakas"};
    let sql = "SELECT * FROM asiakas";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log("tiedot välitetty");
        res.send(result);
    });

});

//haetaan tietty asiakkas
app.get('/asiakas', (reg, res) => {

    var id = reg.body.asiakas_id;


    let post = {title:'asiakas', body: "asiakas"};
    let sql = "SELECT * FROM asiakas WHERE asiakas_id ='"+id+"'";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log("tiedot välitetty");
        res.send(result);
    });

});
//testiyhteys
app.post('/testi1', (reg, res) => {
    res.send(reg.body);
});

// lisätään uusi asiakas
app.post('/lisaa-asikas', (reg, res) => {


    var etunimiq     = reg.body.etunimi;
    var sukunimiq     = reg.body.sukunimi;
    var lahiosoiteq = reg.body.lahiosoite;
    var postitoimipaikkaq     = reg.body.postitoimipaikka;
    var postinroq     = reg.body.postinro;
    var emailq     = reg.body.email;
    var puhelinnroq = reg.body.puhelinnro;
    var laskutustapaq     = reg.body.laskutustapa.data[0];


    let post = {title:'lisää asiakas', body: "lisää asiakas"};
    let sql = "INSERT INTO  asiakas (etunimi, sukunimi, lahiosoite, postitoimipaikka, postinro, email, puhelinnro, laskutustapa) VALUES ('"+etunimiq+"', '"+sukunimiq+"', '"+lahiosoiteq+"', '"+postitoimipaikkaq+"', '"+postinroq+"', '"+emailq+"','"+puhelinnroq+"',"+laskutustapaq+")";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log(result);
        res.send('asiakas lisätty');
    });

});


// poistetaan asiakas
app.delete('/poista-asiakas', (reg, res) => {

    var id = reg.body.asiakas_id;

    let post = {title:'poista asiakas', body: "poista asiakas"};
    let sql = "DELETE FROM asiakas WHERE asiakas_id ="+id+";";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log(result);
        if (result.affectedRows == 0)
        {
            res.send('asiakas on jo poistettu');
        }
        else{
            res.send('asiakas poistettu');
        }

    });
});

// Haetaan tietyn toimipisteen tiedot ID numerolla
app.get('/toimipiste', (reg, res) => {

    var id = reg.body.toimipiste_id;


    let post = {title:'toimipiste', body: "toimipiste"};
    let sql = "SELECT * FROM toimipiste WHERE toimipiste_id ='"+id+"'";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log("tiedot välitetty");
        res.send(result);
    });

});
// haetaan kaikki toimipisteet
app.get('/toimipisteet', (reg, res) => {




    let post = {title:'toimipiste', body: "toimipiste"};
    let sql = "SELECT * FROM toimipiste";
    let query = db.query(sql, post, (err, result) => {
        if(err) throw err;
        console.log("tiedot välitetty");
        res.send(result);
    });

});
