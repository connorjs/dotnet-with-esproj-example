namespace Connorjs.DotNetWithEsprojExample.Hello;

[TestClass]
public class HelloUtilityTest
{
	[DataTestMethod]
	[DataRow(null, "Hello, world!")]
	[DataRow("", "Hello, world!")]
	[DataRow(" ", "Hello,  !")]
	[DataRow("esproj", "Hello, esproj!")]
	public void Hello(string? name, string expected)
	{
		HelloUtility.Hello(name).Should().Be(expected);
	}
}
