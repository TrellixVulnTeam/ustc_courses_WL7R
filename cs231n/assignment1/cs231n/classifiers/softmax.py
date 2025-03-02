import numpy as np
from random import shuffle
from past.builtins import xrange

def softmax_loss_naive(W, X, y, reg):
  """
  Softmax loss function, naive implementation (with loops)

  Inputs have dimension D, there are C classes, and we operate on minibatches
  of N examples.

  Inputs:
  - W: A numpy array of shape (D, C) containing weights.
  - X: A numpy array of shape (N, D) containing a minibatch of data.
  - y: A numpy array of shape (N,) containing training labels; y[i] = c means
    that X[i] has label c, where 0 <= c < C.
  - reg: (float) regularization strength

  Returns a tuple of:
  - loss as single float
  - gradient with respect to weights W; an array of same shape as W
  """
  # Initialize the loss and gradient to zero.
  loss = 0.0
  dW = np.zeros_like(W)

  #############################################################################
  # TODO: Compute the softmax loss and its gradient using explicit loops.     #
  # Store the loss in loss and the gradient in dW. If you are not careful     #
  # here, it is easy to run into numeric instability. Don't forget the        #
  # regularization!                                                           #
  #############################################################################
  N,D=X.shape
  C=W.shape[1]
  scores=X.dot(W)
  for i in xrange(N):
    loss-=np.log(np.exp(scores[i,y[i]])/np.sum(np.exp(scores[i])))
    for j in xrange(C):
      dW[:,j]+=X[i].T*np.exp(scores[i,j])/np.sum(np.exp(scores[i]))
    dW[:,y[i]]-=X[i].T
  loss/=N
  loss+=reg*np.sum(W*W)
  dW/=N
  dW+=reg*2*W
  pass
  #############################################################################
  #                          END OF YOUR CODE                                 #
  #############################################################################

  return loss, dW


def softmax_loss_vectorized(W, X, y, reg):
  """
  Softmax loss function, vectorized version.

  Inputs and outputs are the same as softmax_loss_naive.
  """
  # Initialize the loss and gradient to zero.
  loss = 0.0
  dW = np.zeros_like(W)

  #############################################################################
  # TODO: Compute the softmax loss and its gradient using no explicit loops.  #
  # Store the loss in loss and the gradient in dW. If you are not careful     #
  # here, it is easy to run into numeric instability. Don't forget the        #
  # regularization!                                                           #
  #############################################################################
  N,D=X.shape
  C=W.shape[1]
  scores=X.dot(W)
  loss_N=np.log(np.sum(np.exp(scores),axis=1))
  loss_N-=scores[range(N),y]
  loss=np.sum(loss_N)/N
  loss+=reg*np.sum(W*W)
  dscores=np.exp(scores)/np.sum(np.exp(scores),axis=1)[:,np.newaxis]
  dscores[range(N),y]-=1
  dscores/=N
  dW=X.T.dot(dscores)
  dW+=reg*2*W
  pass
  #############################################################################
  #                          END OF YOUR CODE                                 #
  #############################################################################

  return loss, dW

