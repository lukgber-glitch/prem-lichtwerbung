import { onMounted, onUnmounted } from 'vue'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

// Register ScrollTrigger plugin
gsap.registerPlugin(ScrollTrigger)

export interface ScrollAnimationOptions {
  y?: number
  opacity?: number
  duration?: number
  delay?: number
  stagger?: number
  ease?: string
}

export function useScrollAnimation() {
  /**
   * Animate elements on scroll with fade-in and slide-up
   * @param selector - CSS selector for elements to animate
   * @param options - Animation options
   */
  const animateOnScroll = (selector: string, options: ScrollAnimationOptions = {}) => {
    const defaults = {
      y: 100,
      opacity: 0,
      duration: 1.2,
      ease: 'power4.out'
    }

    const animOptions = { ...defaults, ...options }

    gsap.from(selector, {
      y: animOptions.y,
      opacity: animOptions.opacity,
      duration: animOptions.duration,
      ease: animOptions.ease,
      stagger: animOptions.stagger || 0,
      scrollTrigger: {
        trigger: selector,
        start: 'top 80%',
        toggleActions: 'play none none none',
      }
    })
  }

  /**
   * Create parallax effect for images
   * @param selector - CSS selector for parallax elements
   * @param speed - Parallax speed multiplier (0.1-0.5 recommended)
   */
  const parallaxImage = (selector: string, speed: number = 0.3) => {
    gsap.to(selector, {
      y: `-${speed * 100}%`,
      ease: 'none',
      scrollTrigger: {
        trigger: selector,
        start: 'top bottom',
        end: 'bottom top',
        scrub: 1
      }
    })
  }

  /**
   * Animate headlines with character-by-character reveal
   * @param selector - CSS selector for headline element
   */
  const animateHeadline = (selector: string) => {
    const headline = document.querySelector(selector)
    if (!headline) return

    // Split text into individual characters wrapped in spans
    const text = headline.textContent || ''
    headline.innerHTML = text
      .split('')
      .map(char => `<span style="display: inline-block;">${char === ' ' ? '&nbsp;' : char}</span>`)
      .join('')

    // Animate each character
    gsap.from(`${selector} span`, {
      opacity: 0,
      y: 50,
      stagger: 0.05,
      duration: 0.8,
      ease: 'power4.out',
      scrollTrigger: {
        trigger: selector,
        start: 'top 80%',
        toggleActions: 'play none none none',
      }
    })
  }

  /**
   * Fade in hero section on page load
   */
  const fadeInHero = () => {
    gsap.from('.hero-content', {
      opacity: 0,
      y: 50,
      duration: 1.5,
      ease: 'power4.out',
      delay: 0.2
    })
  }

  /**
   * Clean up ScrollTrigger instances on unmount
   */
  const cleanup = () => {
    ScrollTrigger.getAll().forEach(trigger => trigger.kill())
  }

  // Cleanup on component unmount
  onUnmounted(() => {
    cleanup()
  })

  return {
    animateOnScroll,
    parallaxImage,
    animateHeadline,
    fadeInHero,
    cleanup
  }
}
