import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
	let testController = TestController()
	let testPath = router.grouped("test")
	
	// /test/:string
	testPath.get(String.parameter, use: testController.string)
	
	// /test/:int/secondComponent
	testPath.get(Int.parameter, "secondComponent", use: testController.int)
}

class TestController {
	func string(_ req: Request) throws -> Future<Response> {
		let param = try req.parameters.next(String.self)
		print("String: \(param)")
		return try param.encode(for: req)
	}
	
	func int(_ req: Request) throws -> Future<Response> {
		let param = try req.parameters.next(Int.self)
		print("Int: \(param)")
		return try param.encode(for: req)
	}
}
