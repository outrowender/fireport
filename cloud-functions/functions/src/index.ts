import functions = require('firebase-functions');
import admin = require('firebase-admin');

admin.initializeApp();

//quando um usuário for adicionado no banco
exports.onUserAdded = functions.firestore.document(`users/{id}`).onCreate((doc, evt) => {

    const document = doc.data() as any
    const password = document.p

    doc.ref
        .set({
            e: document.e,
            n: document.n,
            d: evt.timestamp
        })
        .then()
        .catch(err => console.error(err))

    return admin.auth().createUser({
        displayName: document.n,
        email: document.e,
        password,
        uid: evt.params.id
    })
})

//quando um usuário é removido do banco
exports.onUserRemoved = functions.firestore.document(`users/{id}`).onDelete((doc, evt) => {

    return admin.auth().deleteUser(evt.params.id)

})

//quando um usuário é adicionado no admin
exports.onUserDocAdded = functions.auth.user().onCreate((usr, evt) => {

    return admin.firestore().doc(`users/${usr.uid}`).create({
        n: usr.displayName || usr.email,
        e: usr.email,
        d: evt.timestamp
    })

})

//quando um usuário é removido do admin
exports.onUserDocRemoved = functions.auth.user().onDelete((usr, evt) => {

    return admin.firestore().doc(`users/${usr.uid}`).delete()

})