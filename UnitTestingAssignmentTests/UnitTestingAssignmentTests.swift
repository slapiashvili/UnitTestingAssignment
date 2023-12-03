//
//  UnitTestingAssignmentTests.swift
//  UnitTestingAssignmentTests
//
//  Created by Salome Lapiashvili on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTests: XCTestCase {
    
    var cartViewModel: CartViewModel?
    
    override func setUp() {
        super.setUp()
        cartViewModel = CartViewModel()
    }
    
    override func tearDown() {
        cartViewModel = nil
        super.tearDown()
    }
    
    func testFetchProducts() {
        let networkmanager = NetworkManager.shared
        if let cartViewModel = cartViewModel {
            let expectation = self.expectation(description: "FetchProducts")
            cartViewModel.fetchProducts {
                XCTAssertNotNil(cartViewModel.allproducts, "allproducts should not be nil after fetchProducts")
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
    }

    
    func testAddProduct() {
        if let cartViewModel = cartViewModel {
            let product = Product(id: 1, title: "iPhone 9", price: 549.0)
            cartViewModel.allproducts = [product]
            cartViewModel.addProduct(withID: 1)
            XCTAssertEqual(cartViewModel.selectedProducts.count, 1, "One product must be added to selectedProducts")
        }
    }
    
    func testAddRandomProduct() {
        if let cartViewModel = cartViewModel {
            cartViewModel.allproducts = [Product(id: 1, title: "iPhone 9", price: 549.0)]
            cartViewModel.addRandomProduct()
            XCTAssertEqual(cartViewModel.selectedProducts.count, 1, "One product must be added")
        }
    }
    
    func testRemoveProduct() {
        if let cartViewModel = cartViewModel {
            let product = Product(id: 1, title: "iPhone 9", price: 549.0)
            cartViewModel.selectedProducts = [product]
            cartViewModel.removeProduct(withID: 1)
            XCTAssertEqual(cartViewModel.selectedProducts.count, 0, "The product must be removed")
        }
    }
    
    func testClearCart() {
        if let cartViewModel = cartViewModel {
            let product = Product(id: 1, title: "iPhone 9", price: 549.0)
            cartViewModel.selectedProducts = [product]
            cartViewModel.clearCart()
            XCTAssertEqual(cartViewModel.selectedProducts.count, 0, "All products must be removed")
        }
    }
    
    func testSelectedItemsQuantityAndTotalPrice() {
        if let cartViewModel = cartViewModel {
            let product1 = Product(id: 1, title: "iPhone 9", price: 549.0, selectedQuantity: 4)
            let product2 = Product(id: 2, title: "iPhone X", price: 899.0, selectedQuantity: 5)
            cartViewModel.selectedProducts = [product1, product2]

            XCTAssertEqual(cartViewModel.selectedItemsQuantity, 9, "selected quantity should be 9")

            XCTAssertEqual(cartViewModel.totalPrice, 4 * 549.0 + 5 * 899.0, "total price should be the sum of total prices of products")
        }
    }
    
    func testAddWithInvalidID() {
            if let cartViewModel = cartViewModel {
                cartViewModel.allproducts = [Product(id: 1, title: "iPhone 9", price: 549.0)]
                cartViewModel.addProduct(withID: 9647)
                XCTAssertEqual(cartViewModel.selectedProducts.count, 0, "No product should be added with an invalid ID")
            }
        }
}

