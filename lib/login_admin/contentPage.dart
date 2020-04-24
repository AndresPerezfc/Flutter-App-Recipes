
Abstract class Content{
  Future<HomePageRecetas> lista();
  Future<InicioPage> recetas(String id);
  Future<MapsPage> mapa();
  Future<ListMiReceta> mireceta(String id);
  Future<InicioPage> admin();
}


class ContentPage implements Content{
  Future<HomePageRecetas> lista() async{
    return HomePageRecetas();
  }

  Future<InicioPage> recetas(String id) async{
    print('en content page $id');
    return InicioPage(id: id);
  }

  Future<MapsPage> mapa() async{
    return MapsPage();
  }

  Future<ListMiReceta> mireceta(String id) async{
    print ('Listados mis recetas $id')
    return ListMiReceta(id: id);
  }

  Future<InicioPage> admin() async{
    return InicioPage();
  }
}