import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/pages/Home.vue')
    },
    {
      path: '/products',
      name: 'products',
      component: () => import('@/pages/Products.vue')
    },
    {
      path: '/products/:slug',
      name: 'product-detail',
      component: () => import('@/pages/ProductDetail.vue')
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('@/pages/Cart.vue')
    },
    {
      path: '/checkout',
      name: 'checkout',
      component: () => import('@/pages/Checkout.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/pages/Login.vue')
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('@/pages/Register.vue')
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: () => import('@/pages/NotFound.vue')
    }
  ]
})

export default router
