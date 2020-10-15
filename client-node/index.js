const config = require('./config-module')
const Firebird = require('node-firebird')
const firebase = require('firebase')
const fn = require('./functions')

Firebird.attach(config.dbOptions, function (err, db) {

    //se o servidor nao estiver rodando ou algo do tipo
    if (err) {
        throw new Error(`Erro ao conectar ao banco. Verifique usuario e senha`);
    }

    //faz a consulta no banco
    db.query(config.query,

        function (err, result) {

            if (err) {
                console.error(err)
                db.detach();
                return
            }

            if (!result) {
                console.log('Nenhum resultado encontrado para hoje')
                db.detach();
                return
            }

            if (result.length >= 1) {
                uploadToCloud(result[0])
            } else {
                console.log('Nenhum resultado encontrado para hoje')
            }
            //desanexa o banco
            db.detach();
        });

});

//faz upload do relatorio para a nuvem
function uploadToCloud(content) {

    // Initialize Firebase
    var app = firebase.initializeApp(config.firebaseConfig);

    var db = app.firestore();

    //captura o mac do device
    require('getmac').getMac(function (err, macAddress) {

        if (err) {
            console.log(err)
            return
        }

        const today = fn.convertDate(content.DATA)

        const docId = `${today}_${macAddress}`

        //adiciona no banco        
        db.collection(`/clusters/${config.clusterId}/report`)
            .doc(docId)
            .set({
                t: content.TOTAL,
                d: content.DATA,
                c: content.QTD,
                m: macAddress
            })
            .then(function (docRef) {
                console.log('\x1b[36m%s\x1b[0m', `Document ${docId} set/updated`)
            })
            .catch(function (error) {
                console.error("Error adding document: ", error)
            })
    })

}