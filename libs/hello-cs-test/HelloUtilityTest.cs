namespace Connorjs.DotNetWithEsprojExample.Hello;

[TestClass]
public class HelloUtilityTest
{
	[DataTestMethod]
	[DataRow(null, "Hello, world!")]
	[DataRow("", "Hello, world!")]
	[DataRow(" ", "Hello,  !")]
	[DataRow("Nx", "Hello, Nx!")]
	public void Hello(string? name, string expected)
	{
		HelloUtility.Hello(name).Should().Be(expected);
	}
}
