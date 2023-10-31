



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/products_repository.dart';
import 'package:teslo_shop/features/products/infrastructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infrastructure/respositories/products_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accessToken = ref.watch(  authProvider  ).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken)
  );

  return productsRepository;
});