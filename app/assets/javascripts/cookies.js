cookies = {
  get: function(cookieName) {
    var ndx, name, value, cookies = document.cookie.split(";");

    for (ndx = 0; ndx < cookies.length; ndx++) {
      name = cookies[ndx].substr(0,cookies[ndx].indexOf("="));
      value = cookies[ndx].substr(cookies[ndx].indexOf("=")+1);
      name = name.replace(/^\s+|\s+$/g,"");
      if (name === cookieName) {
        return unescape(value);
      }
    }
  },

  set: function(name, val, exdays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var escVal = escape(val) + ((exdays === null) ? "" : "; expires="+exdate.toUTCString());
    document.cookie = name + "=" + escVal;
  },

  checkAndSetDate: function() {
    months = {
      0:  'January',
      1:  'February',
      2:  'March',
      3:  'April',
      4:  'May',
      5:  'June',
      6:  'July',
      7:  'August',
      8:  'September',
      9:  'October',
      10: 'November',
      11: 'December'
    };

    var strDate = this.get("date");
    if (!strDate) {
      var date = new Date();
      strDate = date.getUTCDate() + '.' + months[date.getUTCMonth()] + '.' + date.getUTCFullYear();
      this.set("date", strDate, 365);
    }

    var headerDate = document.getElementById('header_date');
    var footerDate = document.getElementById('footer_date');

    headerDate.innerHTML = strDate;
    footerDate.innerHTML = strDate;
  }
}
