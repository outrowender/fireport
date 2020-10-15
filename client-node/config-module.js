const fs = require('fs');

//verifica arquivo de configuracao
if (!fs.existsSync('config/config.json')) {
    throw new Error("Arquivo de configuracao (config.json) nao encontrado em ./");
}

let rawdata = fs.readFileSync('config/config.json');

let configData = {}

//testa se o arquivo de configuracao esta ok
try {
    configData = JSON.parse(rawdata);
} catch (error) {
    throw new Error("Arquivo de configuracao (config.json) corrompido");
}

const banco = configData.banco

//verifica se o banco de dados existe no endereco indicado
if (!fs.existsSync(banco)) {
    throw new Error(`Arquivo FDB nao encontrado em ${banco}`);
}

const dbHost = configData.host
const dbPort = configData.porta
const usuario = configData.usuario
const senha = configData.senha

const clusterId = configData.key

const query = `
SELECT distinct

    cast(DATAEHORACADASTRO as date) as data,
    sum(VALORPRODUTO) as total,
    count(controle) as qtd
    
FROM TVENDANFCE
    
where cast(DATAEHORACADASTRO as date) = '2019-07-20'

group by (data);
`

module.exports = {
    clusterId,
    banco,
    query,

    dbOptions: {
        host: dbHost,
        port: dbPort,
        database: banco,
        user: usuario,
        password: senha,
        lowercase_keys: false,
        role: null,
        pageSize: 4096
    },

    firebaseConfig: {
        apiKey: "AIzaSyDiY57KAx-ZL-uZbWdvT6ZohHva2dVKm2w",
        authDomain: "sgmaster-wendrpatrck.firebaseapp.com",
        databaseURL: "https://sgmaster-wendrpatrck.firebaseio.com",
        projectId: "sgmaster-wendrpatrck",
        storageBucket: "",
        messagingSenderId: "601111839043",
        appId: "1:601111839043:web:d722fc623cdc7710"
    },
}