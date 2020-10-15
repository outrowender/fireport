module.exports = {
    convertDate: function (date) {
        var today = date;
        var dd = String(today.getDate()).padStart(2, '0')
        var mm = String(today.getMonth() + 1).padStart(2, '0')
        var yyyy = today.getFullYear()

        return (dd + '-' + mm + '-' + yyyy)
    }
}