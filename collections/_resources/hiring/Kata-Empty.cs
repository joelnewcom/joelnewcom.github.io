using System;
					
public class Program
{
	public static void Main()
	{
		new CheckoutFixture().PerformUnitTest();
	}
}

public interface ICheckout
{
	void Scan(char item);
	int Total{get;}
}

public class Checkout : ICheckout
{

	public int Total { get; private set; }
	public void Scan(char item)	{}

}

// This is the unit test section. Please don't change. 
public class CheckoutFixture
{
	
	public void PerformUnitTest()
	{
		ScanMultipleItems("", 0, "Test Checkout Zero");
		ScanMultipleItems("A", 50, "Test Checkout Single A");
		ScanMultipleItems("B", 30, "Test Checkout Single B");
		ScanMultipleItems("C", 20, "Test Checkout Single C");
		ScanMultipleItems("D", 15, "Test Checkout Single D");
		
		ScanMultipleItems("AA", 100, "Test Checkout Multiple AA");
		ScanMultipleItems("AB", 80, "Test Checkout Multiple AB");
		ScanMultipleItems("ABC", 100, "Test Checkout Multiple ABC");
		ScanMultipleItems("ABCD", 115, "Test Checkout Multiple ABCD");
		
		// Additional tests for special prices (A: 3 for 130, B: 2 for 45)
		/*
		ScanMultipleItems("AAA", 130, "Test Checkout Multiple AA");
		ScanMultipleItems("BB", 45, "Test Checkout Multiple AB");
		ScanMultipleItems("AAABB", 175, "Test Checkout Multiple ABC");
		*/
		
	}
	
	private void ScanMultipleItems(string items, int total, string testId)
	{
		// Arrange
		var checkout = new Checkout();

		// Act
		for (int i = 0; i < items.Length; i++)
		{
			checkout.Scan(items[i]);
		}

		// Assert
		Console.WriteLine(total == checkout.Total ? testId + ": PASS" : testId + "FAIL");
	}
} 
