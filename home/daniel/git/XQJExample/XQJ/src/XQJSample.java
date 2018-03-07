import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.xquery.XQConnection;
import javax.xml.xquery.XQDataSource;
import javax.xml.xquery.XQException;
import javax.xml.xquery.XQPreparedExpression;
import javax.xml.xquery.XQResultSequence;

import com.saxonica.xqj.SaxonXQDataSource;

import net.sf.saxon.s9api.DocumentBuilder;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.XQueryCompiler;
import net.sf.saxon.s9api.XQueryEvaluator;
import net.sf.saxon.s9api.XQueryExecutable;
import net.sf.saxon.s9api.XdmNode;
import net.sf.saxon.s9api.XdmSequenceIterator;
import net.sf.saxon.s9api.XdmValue;

public class XQJSample {

	public static void main(String[] args) {
		try {
			System.out.println("XQY internal binding to XML");
			execute();
			System.out.println("XML doco defined at runtime");
			executeCustom();
		}
		catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		catch (XQException e) {
			e.printStackTrace();
		}

		catch (SaxonApiException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * XML document defined in the XQY file
	 * @throws FileNotFoundException
	 * @throws XQException
	 */
	private static void execute() throws FileNotFoundException, XQException{
		InputStream inputStream = new FileInputStream(new File("books.xqy"));
		XQDataSource ds = new SaxonXQDataSource();
		XQConnection conn = ds.getConnection();
		XQPreparedExpression exp = conn.prepareExpression(inputStream);
		XQResultSequence result = exp.executeQuery();

		while (result.next()) {
			System.out.println(result.getItemAsString(null));
		}
	}

	/**
	 * XML document is setup at runtime
	 * @throws SaxonApiException
	 * @throws IOException
	 */
	private static void executeCustom() throws SaxonApiException, IOException {
		Processor saxon = new Processor(false);

		XQueryCompiler compiler = saxon.newXQueryCompiler();
		XQueryExecutable exec = compiler.compile(new File("custom.xqy"));

		DocumentBuilder builder = saxon.newDocumentBuilder();
		XdmNode doc = builder.build(new File ("books2.xml"));

		XQueryEvaluator query = exec.load();
		query.setContextItem(doc);
		XdmValue result = query.evaluate();

		XdmSequenceIterator iterator = result.iterator();

		while (iterator.hasNext()) {
			System.out.println(iterator.next().toString());
		}
	}
}
