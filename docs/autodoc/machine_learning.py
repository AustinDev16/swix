
class SVM:
    """
    Implemented through `OpenCV's SVM`_

    .. seealso:: `OpenCV's SVM`_, `Support vector machines`_

    example:

    .. code-block:: python

        var svm = SVM()

        # our responses. 
        var responses = reshape(ones(2*3), (2, 3))

        #/ OpenCV can fail for too similar inputs (probably synthetic)
        for i in 0..3{
            responses[1][i] = -1
        }

        #/ our targets.
        var targets = ones(2); targets[1] = -1

        #/ train with responses
        svm.train(responses, targets: targets)

        #/ predict
        var y = -1 * ones(3) // must have same size!
        var result = svm.predict(y)
    """
    M = "number of responses" #: The number of responses.
    N = "number of variables in a response" #: The number of variables.
    kernel_type = "kernel type" #: Useful in mapping to a nonlinear function.
    svm_type = "SVM type" #: Can drastically change performance.
    def setParams(svm_type, kernel, nu=0.5):
        """
        :param svm_type: Assumed to be either C_SVC, ONE_CLASS, NU_SVC or NU_SVR
        :param kernel: Assumed to be one of LIENAR or SIGMOID
        :type kernel: String
        :type svm_type: String

        Sets the parameters for the SVM.
        """
    def train(responses, targets):
        """
        :param resonses: The matrix of responses to some (known!) variable.
        :param targets: The known variables a response is associated with.
        :type targets: ndarray
        :type responses: matrix
        """
    def predict(responses):
        """
        :param responses: The response to some unknown variable.
        :type responses: matrix, ndarray
        :rtype: ndarray, Double
        """
class kNearestNeighbors:
    """
    .. seealso:: `k-nearest neighbors algorithm`_
    .. warning:: My simple test failed.
    """
    N = "variables" #: the number of variables you train for
    M = "responses" #: the number of variables in a response
    def train(responses, targets):
        """
        :param responses: The responses.
        :type responses: matrix
        :param targets: The targets you *know* exist.
        :type targets: ndarray
        """
    def predict(x, k):
        """
        :param x: The reponse you want to train for.
        :type x: ndarray
        :param k: The number of neighest neighbors you want to train against.
        :type k: Int
        :rtype: Double. The predicted response.
        """
