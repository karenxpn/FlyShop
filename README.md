# FlyShop

Services
    AuthService: 1) connect to server -> get verification code -> login with it
    AllShopService: fetch all shops from server in ShopModel form ( name, image )
    ShopService: fetch all products of given shop ( [ProductModel] )
    NewService: fetch all product of new collection( [ProductModel] )
    SaleService: fetch all products that are under sale ( [ProductModel] )
    FilterService: filet products by given criterias
    HomeService: fetch trend collection ( ProductModel )
    CartService: post cart items to server to notify that new order is ready
    InitPayment: initialize payment and get ready for transaction
    GetPaymentDetails: Finish transaction


ViewModels
    AuthViewModel: AuthService
    FilterViewModel: FilterService
    AllShopsViewModel: get all shops from server
    NewViewModel: get new products ( [ProductViewModel] )
    SaleViewModel: get products that are under sale ( [ProductViewModel] )
    HomeViewModel: get trend products
    ShopViewModel: get all products of requested shop ( [ProductViewModel )
    CartViewModel: CartService
    PaymentViewModel: InitPayment, GetPaymentDetails

Views

    HomeScreen:
      Filter: FilterView with all subviews
      Info: Information about company
    HomeView -> on click -> trending products

    AllShops
    AllShopsView presents a grid with AllShopGridCell view
    Single shop presents a grid with SingleProduct view and each one navigates to SelectedProductView
    SelectedProduct view has SizeSheet which presents available sizes of current product

    New
    NewView presents a grid with SingleNewProduct view
    Each SingleNewProduct navigates to SelectedProduct

    Sale
    SaleView presents a grid with SingleSaleProduct view
    Each SingleSaleProduct navigates to SelectedProduct


