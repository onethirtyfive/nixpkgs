lib: self: super:

with self;

let
  # Removing recurseForDerivation prevents derivations of aliased attribute
  # set to appear while listing all the packages available.
  removeRecurseForDerivations = alias: with lib;
      if alias.recurseForDerivations or false then
            removeAttrs alias ["recurseForDerivations"]
                else alias;

  # Disabling distribution prevents top-level aliases for non-recursed package
  # sets from building on Hydra.
  removeDistribute = alias: with lib;
    if isDerivation alias then
      dontDistribute alias
    else alias;

  # Make sure that we are not shadowing something from
  # python-packages.nix.
  checkInPkgs = n: alias: if builtins.hasAttr n super
                          then throw "Alias ${n} is still in python-packages.nix"
                          else alias;

  mapAliases = aliases:
    lib.mapAttrs (n: alias: removeDistribute
                             (removeRecurseForDerivations
                              (checkInPkgs n alias)))
                     aliases;
in

  ### Deprecated aliases - for backward compatibility

mapAliases ({
  abodepy = jaraco-abode; # added 2023-02-01
  acebinf = throw "acebinf has been removed because it is abandoned and broken."; # Added 2023-05-19
  aioh2 = throw "aioh2 has been removed because it is abandoned and broken."; # Added 2022-03-30
  ansible-base = throw "ansible-base has been removed, because it is end of life"; # added 2022-03-30
  ansible-doctor = throw "ansible-doctor has been promoted to a top-level attribute"; # Added 2023-05-16
  ansible-later = throw "ansible-later has been promoted to a top-level attribute"; # Added 2023-05-16
  ansible-lint = throw "ansible-lint has been promoted to a top-level attribute"; # Added 2023-05-16
  anyjson = throw "anyjson has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2022-01-18
  apache-airflow = throw "apache-airflow has been moved out of pythonPackages and is available as a standalone package"; # added 2023-06-05
  argon2_cffi = argon2-cffi; # added 2022-05-09
  APScheduler = apscheduler; # added 2023-02-19
  asyncio-nats-client = nats-py; # added 2022-02-08
  awkward0 = throw "awkward0 has been removed, use awkward instead"; # added 2022-12-13
  Babel = babel; # added 2022-05-06
  bedup = throw "bedup was removed because it was broken and abandoned upstream"; # added 2023-02-04
  bitcoin-price-api = throw "bitcoin-price-api has been removed, it was using setuptools 2to3 translation feautre, which has been removed in setuptools 58"; # added 2022-02-15
  BlinkStick = blinkstick; # added 2023-02-19
  blockdiagcontrib-cisco = throw "blockdiagcontrib-cisco is not compatible with blockdiag 2.0.0 and has been removed."; # added 2020-11-29
  bsblan = python-bsblan; # added 2022-11-04
  btchip = btchip-python; # added 2023-03-03
  buildbot = throw "use pkgs.buildbot instead"; # added 2022-04-07
  buildbot-ui = throw "use pkgs.buildbot-ui instead"; # added 2022-04-07
  buildbot-full = throw "use pkgs.buildbot-full instead"; # added 2022-04-07
  buildbot-plugins = throw "use pkgs.buildbot-plugins instead"; # added 2022-04-07
  buildbot-worker = throw "use pkgs.buildbot-worker instead"; # added 2022-04-07
  buildbot-pkg = throw "buildbot-pkg has been removed, it's only internally used in buildbot"; # added 2022-04-07
  bt_proximity = bt-proximity; # added 2021-07-02
  BTrees = btrees; # added 2023-02-19
  carrot = throw "carrot has been removed, as its development was discontinued in 2012"; # added 2022-01-18
  cchardet = faust-cchardet; # added 2023-03-02
  class-registry = phx-class-registry; # added 2021-10-05
  codespell = throw "codespell has been promoted to a top-level attribute"; # Added 2022-10-02
  ColanderAlchemy = colanderalchemy; # added 2023-02-19
  CommonMark = commonmark; # added 2023-02-1
  ConfigArgParse = configargparse; # added 2021-03-18
  coronavirus = throw "coronavirus was removed, because the source is not providing the data anymore."; # added 2023-05-04
  cozy = throw "cozy was removed because it was not actually https://pypi.org/project/Cozy/."; # added 2022-01-14
  cryptography_vectors = "cryptography_vectors is no longer exposed in python*Packages because it is used for testing cryptography only."; # Added 2022-03-23
  dask-xgboost = throw "dask-xgboost was removed because its features are available in xgboost"; # added 2022-05-24
  dateutil = python-dateutil; # added 2021-07-03
  demjson = throw "demjson has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2022-01-18
  detox = throw "detox is no longer maintained, and was broken since may 2019"; # added 2020-07-04
  dftfit = throw "dftfit dependency lammps-cython no longer builds"; # added 2021-07-04
  dictpath = pathable; # added 2023-01-28
  diff_cover = diff-cover; # added 2021-07-02
  discogs_client = discogs-client; # added 2021-07-02
  djangorestframework-jwt = drf-jwt; # added 2021-07-20
  django-sampledatahelper = throw "django-sampledatahelper was removed because it is no longer compatible to latest Django version"; # added 2022-07-18
  django_2 = throw "Django 2 has reached it's projected EOL in 2022/04 and has therefore been removed."; # added 2022-03-05
  django_appconf = django-appconf; # added 2022-03-03
  django-discover-runner = throw "django-discover-runner was removed because it is no longer maintained."; # added 2022-11-21
  django_environ = django-environ; # added 2021-12-25
  django_extensions = django-extensions; # added 2022-01-09
  django_guardian = django-guardian; # added 2022-05-19
  django_hijack = django-hijack; # added 2023-05-16
  django_hijack_admin = django-hijack-admin; # added 2023-05-16
  django_modelcluster = django-modelcluster; # added 2022-04-02
  django_reversion = django-reversion; # added 2022-06-18
  django_polymorphic = django-polymorphic; # added 2022-05-24
  django_redis = django-redis; # added 2021-10-11
  django_taggit = django-taggit; # added 2021-10-11
  dns = dnspython; # added 2017-12-10
  dogpile_cache = dogpile-cache; # added 2021-10-28
  dogpile-core = throw "dogpile-core is no longer maintained, use dogpile-cache instead"; # added 2021-11-20
  eebrightbox = throw "eebrightbox is unmaintained upstream and has therefore been removed"; # added 2022-02-03
  EasyProcess = easyprocess; # added 2023-02-19
  email_validator = email-validator; # added 2022-06-22
  Fabric = fabric; # addedd 2023-02-19
  face_recognition = face-recognition; # added 2022-10-15
  face_recognition_models = face-recognition-models; # added 2022-10-15
  fake_factory = throw "fake_factory has been removed because it is unused and deprecated by upstream since 2016."; # added 2022-05-30
  faulthandler = throw "faulthandler is built into ${python.executable}"; # added 2021-07-12
  inherit (super.pkgs) fetchPypi; # added 2023-05-25
  filemagic = throw "inactive since 2014, so use python-magic instead"; # added 2022-11-19
  flaskbabel = flask-babel; # added 2023-01-19
  flask_login = flask-login; # added 2022-10-17
  flask-restplus = throw "flask-restplus is no longer maintained, use flask-restx instead"; # added 2023-02-21
  flask_sqlalchemy = flask-sqlalchemy; # added 2022-07-20
  flask_testing = flask-testing; # added 2022-04-25
  flask_wtf = flask-wtf; # added 2022-05-24
  FormEncode = formencode; # added 2023-02-19
  functorch = throw "functorch is now part of the torch package and has therefore been removed. See https://github.com/pytorch/functorch/releases/tag/v1.13.0 for more info."; # added 2022-12-01
  garages-amsterdam = throw "garages-amsterdam has been renamed odp-amsterdam."; # added 2023-01-04
  garminconnect-ha = garminconnect; # added 2022-02-05
  gdtoolkit = throw "gdtoolkit has been promoted to a top-level attribute"; # added 2023-02-15
  GeoIP = geoip; # added 2023-02-19
  gigalixir = throw "gigalixir has been promoted to a top-level attribute"; # Added 2022-10-02
  gitdb2 = throw "gitdb2 has been deprecated, use gitdb instead."; # added 2020-03-14
  GitPython = gitpython; # added 2022-10-28
  glances = throw "glances has moved to pkgs.glances"; # added 2020-20-28
  glasgow = throw "glasgow has been promoted to a top-level attribute"; # added 2023-02-05
  google_api_python_client = google-api-python-client; # added 2021-03-19
  googleapis_common_protos = googleapis-common-protos; # added 2021-03-19
  google-apitools = throw "google-apitools was removed because it is deprecated and unsupported by upstream"; # added 2023-02-25
  gpyopt = throw "gpyopt was remove because it's been archived upstream"; # added 2023-06-07
  graphite_api = throw "graphite_api was removed, because it is no longer maintained"; # added 2022-07-10
  graphite_beacon = throw "graphite_beacon was removed, because it is no longer maintained"; # added 2022-07-09
  grpc_google_iam_v1 = grpc-google-iam-v1; # added 2021-08-21
  ha-av = throw "ha-av was removed, because it is no longer maintained"; # added 2022-04-06
  HAP-python = hap-python; # added 2021-06-01
  hangups = throw "hangups was removed because Google Hangouts has been shut down"; # added 2023-02-13
  hbmqtt = throw "hbmqtt was removed because it is no longer maintained"; # added 2021-11-07
  hdlparse = throw "hdlparse has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2022-01-18
  HTSeq = htseq; # added 2023-02-19
  hyperkitty = throw "Please use pkgs.mailmanPackages.hyperkitty"; # added 2022-04-29
  ihatemoney = throw "ihatemoney was removed because it is no longer maintained downstream"; # added 2023-04-08
  IMAPClient = imapclient; # added 2021-10-28
  imdbpy = throw "imdbpy has been renamed to cinemagoer"; # added 2022-08-08
  intreehook =  throw "intreehooks has been removed because it is obsolete as a backend-path key was added to PEP 517"; # added 2023-04-11
  ipaddress = throw "ipaddress has been removed because it is no longer required since python 2.7."; # added 2022-05-30
  influxgraph = throw "influxgraph has been removed because it is no longer maintained"; # added 2022-07-10
  itanium_demangler = itanium-demangler; # added 2022-1017
  JayDeBeApi = jaydebeapi; # added 2023-02-19
  jinja2_time = jinja2-time; # added 2022-11-07
  JPype1 = jpype1; # added 2023-02-19
  jupyter_client = jupyter-client; # added 2021-10-15
  jupyter_core = jupyter-core; # added 2023-01-05
  jupyter_server = jupyter-server; # added 2023-01-05
  Kajiki = kajiki; # added 2023-02-19
  Keras = keras; # added 2021-11-25
  ldap = python-ldap; # added 2022-09-16
  lammps-cython = throw "lammps-cython no longer builds and is unmaintained"; # added 2021-07-04
  logilab_astng = throw "logilab-astng has not been released since 2013 and is unmaintained"; # added 2022-11-29
  logilab_common = logilab-common; # added 2022-11-21
  loo-py = loopy; # added 2022-05-03
  Mako = mako; # added 2023-02-19
  Markups = markups; # added 2022-02-14
  MDP = mdp; # added 2023-02-19
  MechanicalSoup = mechanicalsoup; # added 2021-06-01
  memcached = python-memcached; # added 2022-05-06
  mailman = throw "Please use pkgs.mailman"; # added 2022-04-29
  mailman-hyperkitty = throw "Please use pkgs.mailmanPackages.mailman-hyperkitty"; # added 2022-04-29
  mailman-web = throw "Please use pkgs.mailman-web"; # added 2022-04-29
  manticore = throw "manticore has been removed because its dependency wasm no longer builds and is unmaintained"; # added 2023-05-20
  markerlib = throw "markerlib has been removed because it's abandoned since 2013"; # added 2023-05-19
  mistune_0_8 = throw "mistune_0_8 was removed because it was outdated and insecure"; # added 2022-08-12
  mistune_2_0 = mistune; # added 2022-08-12
  mox = throw "mox was removed because it is unmaintained"; # added 2023-02-21
  mutmut = throw "mutmut has been promoted to a top-level attribute"; # added 2022-10-02
  net2grid = gridnet; # add 2022-04-22
  nghttp2 = throw "in 1.52.0 removed deprecated python bindings."; # added 2023-06-08
  nose-cover3 = throw "nose-cover3 has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2022-02-16
  nose_progressive = throw "nose_progressive has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; #added 2023-02-21
  notifymuch = throw "notifymuch has been promoted to a top-level attribute"; # added 2022-10-02
  Nuitka = nuitka; # added 2023-02-19
  ntlm-auth = throw "ntlm-auth has been removed, because it relies on the md4 implementation provided by openssl. Use pyspnego instead.";
  ordereddict = throw "ordereddict has been removed because it is only useful on unsupported python versions."; # added 2022-05-28
  pafy = throw "pafy has been removed because it is unmaintained and only a dependency of mps-youtube, itself superseded by yewtube"; # Added 2023-01-19
  pam = python-pam; # added 2020-09-07.
  PasteDeploy = pastedeploy; # added 2021-10-07
  pathpy = path; # added 2022-04-12
  pdfminer = pdfminer-six; # added 2022-05-25
  pep257 = pydocstyle; # added 2022-04-12
  poetry = throw "poetry was promoted to a top-level attribute, use poetry-core to build Python packages"; # added 2023-01-09
  poetry2conda = throw "poetry2conda was promoted to a top-level attribute"; # Added 2022-10-02
  poster3 = throw "poster3 is unmaintained and source is no longer available"; # added 2023-05-29
  postorius = throw "Please use pkgs.mailmanPackages.postorius"; # added 2022-04-29
  powerlineMemSegment = powerline-mem-segment; # added 2021-10-08
  privacyidea = throw "privacyidea has been renamed to pkgs.privacyidea"; # added 2021-06-20
  prometheus_client = prometheus-client; # added 2021-06-10
  prompt_toolkit = prompt-toolkit; # added 2021-07-22
  protonup = protonup-ng; # Added 2022-11-06
  pur = throw "pur has been renamed to pkgs.pur"; # added 2021-11-08
  pushbullet = pushbullet-py;  # Added 2022-10-15
  Pweave = pweave; # added 2023-02-19
  pyalmond = throw "pyalmond has been removed, since its API endpoints have been shutdown"; # added 2023-02-02
  pyblake2 = throw "pyblake2 is deprecated in favor of hashlib"; # added 2023-04-23
  pydrive = throw "pydrive is broken and deprecated and has been replaced with pydrive2."; # added 2022-06-01
  PyGithub = pygithub; # added 2023-02-19
  pyGtkGlade = throw "Glade support for pygtk has been removed"; # added 2022-01-15
  pycallgraph = throw "pycallgraph has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2022-01-18
  pychef = throw "pychef has been removed because it's been archived upstream and abandoned since 2017."; # added 2022-11-14
  PyChromecast = pychromecast; # added 2023-02-19
  pycryptodome-test-vectors = throw "pycryptodome-test-vectors has been removed because it is an internal package to pycryptodome"; # added 2022-05-28
  pyflunearyou = pyoutbreaksnearme; # added 2023-02-11
  pyialarmxr = pyialarmxr-homeassistant; # added 2022-06-07
  pyialarmxr-homeassistant = throw "The package was removed together with the component support in home-assistant 2022.7.0"; # added 2022-07-07
  PyICU = pyicu; # Added 2022-12-22
  pyjson5 = json5; # added 2022-08-28
  pylibgen = throw "pylibgen is unmaintained upstreamed, and removed from nixpkgs"; # added 2020-06-20
  PyLD = pyld; # added 2022-06-22
  pymc3 = pymc; # added 2022-06-05, module was rename starting with 4.0.0
  pymssql = throw "pymssql has been abandoned upstream."; # added 2020-05-04
  PyMVGLive = pymvglive; # added 2023-02-19
  pyramid_hawkauth = throw "pyramid_hawkauth has been removed because it is no longer maintained"; # added 2023-02-2
  pyramid_jinja2 = pyramid-jinja2; # added 2023-06-06
  pyreadability = readability-lxml; # added 2022-05-24
  pyroute2-core = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-ethtool = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-ipdb = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-ipset = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-ndb = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-nftables = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-nslink = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  pyroute2-protocols = throw "pyroute2 migrated back to a single package scheme in version 0.7.1"; # added 2022-07-16
  Pyro4 = pyro4; # added 2023-02-19
  Pyro5 = pyro5; # added 2023-02-19
  PyRSS2Gen = pyrss2gen; # added 2023-02-19
  pysha3 = throw "pysha3 has been removed, use safe-pysha3 instead"; # added 2023-05-20
  pysmart-smartx = pysmart; # added 2021-10-22
  pysparse = throw "pysparse has been abandoned upstream."; # added 2023-02-28
  pyspotify = throw "pyspotify has been removed because Spotify stopped supporting libspotify"; # added 2022-05-29
  PyStemmer = pystemmer; # added 2023-02-19
  pytest_6 = pytest; # added 2022-02-10
  pytestcov = pytest-cov; # added 2021-01-04
  pytest-pep8 = pytestpep8; # added 2021-01-04
  pytest-pep257 = throw "pytest-pep257 was removed, as the pep257 package was migrated into pycodestyle"; # added 2022-04-12
  pytest-pythonpath = throw "pytest-pythonpath is obsolete as of pytest 7.0.0 and has been removed"; # added 2022-03-09
  pytestpep8 = throw "pytestpep8 was removed because it is abandoned and no longer compatible with pytest v6.0"; # added 2020-12-10
  pytestquickcheck = pytest-quickcheck; # added 2021-07-20
  pytestrunner = pytest-runner; # added 2021-01-04
  python-forecastio = throw "python-forecastio has been removed, as the Dark Sky service was shut down."; # added 2023-04-05
  python-igraph = igraph; # added 2021-11-11
  python_keyczar = throw "python_keyczar has been removed because it's been archived upstream and deprecated"; # added 2023-05-16
  python-lz4 = lz4; # added 2018-06-01
  python_magic = python-magic; # added 2022-05-07
  python_mimeparse = python-mimeparse; # added 2021-10-31
  python-language-server = throw "python-language-server is no longer maintained, use the python-lsp-server community fork instead."; # Added 2022-08-03
  python-Levenshtein = levenshtein;
  python-subunit = subunit; # added 2021-09-10
  pytest_xdist = pytest-xdist; # added 2021-01-04
  python_simple_hipchat = python-simple-hipchat; # added 2021-07-21
  pytoml = throw "pytoml has been removed because it is unmaintained and is superseded by toml"; # Added 2023-04-11
  pytorch = torch; # added 2022-09-30
  pytorch-bin = torch-bin; # added 2022-09-30
  pytorchWithCuda = torchWithCuda; # added 2022-09-30
  pytorchWithoutCuda = torchWithoutCuda; # added 2022-09-30
  pytwitchapi = twitchapi; # added 2022-03-07
  pyvcf = throw "pyvcf has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2023-05-19
  PyVirtualDisplay = pyvirtualdisplay; # added 2023-02-19
  qasm2image = throw "qasm2image is no longer maintained (since November 2018), and is not compatible with the latest pythonPackages.qiskit versions."; # added 2020-12-09
  Quandl = quandl; # added 2023-02-19
  qiskit-aqua = throw "qiskit-aqua has been removed due to deprecation, with its functionality moved to different qiskit packages";
  rdflib-jsonld = throw "rdflib-jsonld is not compatible with rdflib 6"; # added 2021-11-05
  retworkx = rustworkx; # added 2023-05-14
  repeated_test = repeated-test; # added 2022-11-15
  requests_oauthlib = requests-oauthlib; # added 2022-02-12
  requests_toolbelt = requests-toolbelt; # added 2017-09-26
  rig = throw "rig has been removed because it was pinned to python 2.7 and 3.5, failed to build and is otherwise unmaintained"; # added 2022-11-28
  rl-coach = "rl-coach was removed because the project is discontinued and was archived by upstream"; # added 2023-05-03
  roboschool = throw "roboschool is deprecated in favor of PyBullet and has been removed"; # added 2022-01-15
  ROPGadget = ropgadget; # added 2021-07-06
  rotate-backups = throw "rotate-backups was removed in favor of the top-level rotate-backups"; # added 2021-07-01
  ruamel_base = ruamel-base; # added 2021-11-01
  ruamel_yaml = ruamel-yaml; # added 2021-11-01
  ruamel_yaml_clib = ruamel-yaml-clib; # added 2021-11-01
  runway-python = throw "SDK has been deprecated and was archived by upstream"; # added 2023-05-03
  sapi-python-client = kbcstorage; # added 2022-04-20
  scikitimage = scikit-image; # added 2023-05-14
  scikitlearn = scikit-learn; # added 2021-07-21
  selectors34 = throw "selectors34 has been removed: functionality provided by Python itself; archived by upstream."; # added 2021-06-10
  setuptools_scm = setuptools-scm; # added 2021-06-03
  sharkiqpy = sharkiq; # added 2022-05-21
  ssh-mitm = throw "ssh-mitm was removed in favor of the top-level ssh-mitm"; # added 2023-05-09
  smart_open = smart-open; # added 2021-03-14
  smmap2 = throw "smmap2 has been deprecated, use smmap instead."; # added 2020-03-14
  somecomfort = throw "somecomfort was removed because Home Assistant switched to aiosomecomfort"; # added 2023-02-01
  SPARQLWrapper = sparqlwrapper;
  sphinx-jquery = sphinxcontrib-jquery; # added 2023-02-24
  sphinx_rtd_theme = sphinx-rtd-theme; # added 2022-08-03
  sphinxcontrib-autoapi = sphinx-autoapi; # added 2023-02=28
  sphinxcontrib_plantuml = sphinxcontrib-plantuml; # added 2021-08-02
  sqlalchemy_migrate = sqlalchemy-migrate; # added 2021-10-28
  SQLAlchemy-ImageAttach = throw "sqlalchemy-imageattach has been removed as it is incompatible with sqlalchemy 1.4 and unmaintained"; # added 2022-04-23
  suds-jurko = throw "suds-jurko has been removed, it was using setuptools 2to3 translation feature, which has been removed in setuptools 58"; # added 2023-02-27
  suseapi = throw "suseapi has been removed because it is no longer maintained"; # added 2023-02-27
  tensorflow-bin_2 = tensorflow-bin; # added 2021-11-25
  tensorflow-build_2 = tensorflow-build; # added 2021-11-25
  tensorflow-estimator = tensorflow-estimator-bin; # added 2023-01-17
  tensorflow-estimator_2 = tensorflow-estimator; # added 2021-11-25
  tensorflow-tensorboard = tensorboard; # added 2022-03-06
  tensorflow-tensorboard_2 = tensorflow-tensorboard; # added 2021-11-25
  Theano = theano; # added 2023-02-19
  TheanoWithCuda = theanoWithCuda; # added 2023-02-19
  TheanoWithoutCuda = theanoWithoutCuda; # added 2023-02-19
  transip = throw "transip has been removed because it is no longer maintained. TransIP SOAP V5 API was marked as deprecated"; # added 2023-02-27
  tumpa = throw "tumpa was promoted to a top-level attribute"; # added 2022-11-19
  tvnamer = throw "tvnamer was moved to pkgs.tvnamer"; # added 2021-07-05
  types-cryptography = throw "types-cryptography has been removed because it is obsolete since cryptography version 3.4.4."; # added 2022-05-30
  types-paramiko = throw "types-paramiko has been removed because it was unused."; # added 2022-05-30
  unittest2 = throw "unittest2 has been removed as it's a backport of unittest that's unmaintained and not needed beyond Python 3.4."; # added 2022-12-01
  uproot3 = throw "uproot3 has been removed, use uproot instead"; # added 2022-12-13
  uproot3-methods = throw "uproot3-methods has been removed"; # added 2022-12-13
  virtual-display = throw "virtual-display has been renamed to PyVirtualDisplay"; # added 2023-01-07
  Wand = wand; # added 2022-11-13
  wasm = throw "wasm has been removed because it no longer builds and is unmaintained"; # added 2023-05-20
  WazeRouteCalculator = wazeroutecalculator; # added 2021-09-29
  weakrefmethod = throw "weakrefmethod was removed since it's not needed in Python >= 3.4"; # added 2022-12-01
  webapp2 = throw "webapp2 is unmaintained since 2012"; # added 2022-05-29
  websocket_client = websocket-client; # added 2021-06-15
  word2vec = throw "word2vec has been removed because it is abandoned"; # added 2023-05-22
  wxPython_4_0 = throw "wxPython_4_0 has been removed, use wxPython_4_2 instead"; # added 2023-03-19
  wxPython_4_1 = throw "wxPython_4_1 has been removed, use wxPython_4_2 instead"; # added 2023-03-19
  WSME = wsme; # added 2023-02-19
  xenomapper = throw "xenomapper was moved to pkgs.xenomapper"; # added 2021-12-31
  XlsxWriter = xlsxwriter; # added 2023-02-19
  Yapsy = yapsy; # added 2023-02-19
  zc-buildout221 = zc-buildout; # added 2021-07-21
  zc_buildout_nix = throw "zc_buildout_nix was pinned to a version no longer compatible with other modules";
})
