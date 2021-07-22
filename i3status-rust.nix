id: {
  "${id}" = {
    blocks = [
      {
        block = "disk_space";
        path = "/";
        alias = "/";
        info_type = "available";
        unit = "GB";
        interval = 60;
        warning = 50.0;
        alert = 30;
      }
    ];
  };
}
