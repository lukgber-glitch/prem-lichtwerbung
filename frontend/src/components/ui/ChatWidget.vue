<template>
  <div>
    <!-- Floating Chat Button -->
    <button
      @click="toggleChat"
      :class="[
        'fixed bottom-6 right-6 z-50 w-16 h-16 rounded-full shadow-lg transition-all duration-300',
        'flex items-center justify-center',
        isOpen 
          ? 'bg-primary hover:shadow-xl' 
          : 'bg-primary hover:shadow-xl hover:scale-110'
      ]"
      aria-label="Chat with us"
    >
      <!-- Message Icon (when closed) -->
      <MessageCircle 
        v-if="!isOpen"
        :size="32" 
        class="text-white"
        :stroke-width="2"
      />
      
      <!-- Close Icon (when open) -->
      <X 
        v-else
        :size="32" 
        class="text-white"
        :stroke-width="2"
      />

      <!-- Unread Badge -->
      <span 
        v-if="unreadCount > 0 && !isOpen"
        class="absolute -top-1 -right-1 w-6 h-6 bg-primary text-white text-xs font-bold rounded-full flex items-center justify-center animate-pulse"
      >
        {{ unreadCount }}
      </span>
    </button>

    <!-- Chat Modal -->
    <Transition
      enter-active-class="transition-all duration-300 ease-out"
      leave-active-class="transition-all duration-200 ease-in"
      enter-from-class="opacity-0 translate-y-full md:translate-y-0 md:scale-95"
      enter-to-class="opacity-100 translate-y-0 md:scale-100"
      leave-from-class="opacity-100 translate-y-0 md:scale-100"
      leave-to-class="opacity-0 translate-y-full md:translate-y-0 md:scale-95"
    >
      <div
        v-if="isOpen"
        class="fixed inset-x-0 bottom-0 md:bottom-6 md:right-6 md:inset-x-auto z-40"
      >
        <div class="bg-white shadow-2xl w-full md:w-96 h-[80vh] md:h-[600px] flex flex-col overflow-hidden">
          <!-- Header -->
          <div class="bg-primary p-4 flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 bg-white bg-opacity-20 rounded-full flex items-center justify-center">
                <MessageSquare :size="24" class="text-white" :stroke-width="2" />
              </div>
              <div>
                <h3 class="font-bold text-white">Chat with us</h3>
                <p class="text-xs text-white opacity-80">We typically reply instantly</p>
              </div>
            </div>
            <button
              @click="toggleChat"
              class="text-white hover:bg-white hover:bg-opacity-20 rounded-full p-2 transition-colors"
              aria-label="Close chat"
            >
              <X :size="24" class="text-white" :stroke-width="2" />
            </button>
          </div>

          <!-- Chat Messages -->
          <div class="flex-1 overflow-y-auto p-4 space-y-4 bg-light-bg">
            <!-- Welcome Message -->
            <div class="flex items-start gap-3">
              <div class="w-8 h-8 bg-primary rounded-full flex items-center justify-center flex-shrink-0">
                <UserCircle2 :size="20" class="text-white" :stroke-width="2" />
              </div>
              <div class="bg-white shadow-sm p-3 max-w-[80%]">
                <p class="text-sm text-gray-800">
                  Hello! Welcome to Prem-Lichtwerbung. How can we help you today?
                </p>
                <span class="text-xs text-gray-500 mt-1 block">Just now</span>
              </div>
            </div>

            <!-- Placeholder Notice -->
            <div class="bg-primary bg-opacity-10 border border-primary p-4 text-center">
              <Info :size="48" class="mx-auto mb-3 text-primary" :stroke-width="2" />
              <p class="text-sm font-semibold text-gray-900 mb-2">Live Chat Integration</p>
              <p class="text-xs text-gray-600 mb-3">
                Connect your preferred live chat service to enable real-time customer support:
              </p>
              <ul class="text-xs text-left text-gray-700 space-y-1 max-w-xs mx-auto list-disc list-inside">
                <li>Intercom</li>
                <li>Tawk.to</li>
                <li>Crisp</li>
                <li>Zendesk Chat</li>
                <li>LiveChat</li>
              </ul>
            </div>

            <!-- Example Messages -->
            <div v-for="(message, index) in demoMessages" :key="index">
              <!-- Customer Message (right aligned) -->
              <div v-if="message.type === 'customer'" class="flex items-start gap-3 justify-end">
                <div class="bg-primary text-white shadow-sm p-3 max-w-[80%]">
                  <p class="text-sm">{{ message.text }}</p>
                  <span class="text-xs opacity-75 mt-1 block">{{ message.time }}</span>
                </div>
                <div class="w-8 h-8 bg-primary rounded-full flex items-center justify-center flex-shrink-0">
                  <User :size="20" class="text-white" :stroke-width="2" />
                </div>
              </div>

              <!-- Agent Message (left aligned) -->
              <div v-else class="flex items-start gap-3">
                <div class="w-8 h-8 bg-primary rounded-full flex items-center justify-center flex-shrink-0">
                  <UserCircle2 :size="20" class="text-white" :stroke-width="2" />
                </div>
                <div class="bg-white shadow-sm p-3 max-w-[80%]">
                  <p class="text-sm text-gray-800">{{ message.text }}</p>
                  <span class="text-xs text-gray-500 mt-1 block">{{ message.time }}</span>
                </div>
              </div>
            </div>

            <!-- Typing Indicator (optional) -->
            <div v-if="isTyping" class="flex items-start gap-3">
              <div class="w-8 h-8 bg-primary rounded-full flex items-center justify-center flex-shrink-0">
                <UserCircle2 :size="20" class="text-white" :stroke-width="2" />
              </div>
              <div class="bg-white shadow-sm p-3">
                <div class="flex gap-1">
                  <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></span>
                  <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.1s;"></span>
                  <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.2s;"></span>
                </div>
              </div>
            </div>
          </div>

          <!-- Input Area -->
          <div class="p-4 bg-white border-t border-gray-200">
            <div class="flex gap-2">
              <input
                v-model="messageInput"
                type="text"
                placeholder="Type your message..."
                class="flex-1 px-4 py-3 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary transition-all"
                @keypress.enter="sendMessage"
              />
              <button
                @click="sendMessage"
                :disabled="!messageInput.trim()"
                class="px-4 py-3 bg-primary text-white hover:shadow-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed flex-shrink-0"
                aria-label="Send message"
              >
                <Send :size="24" class="text-white" :stroke-width="2" />
              </button>
            </div>
            <p class="text-xs text-gray-500 mt-2 text-center">
              Demo mode - Connect your live chat service for real conversations
            </p>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Backdrop (mobile only) -->
    <Transition
      enter-active-class="transition-opacity duration-300"
      leave-active-class="transition-opacity duration-200"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="isOpen"
        class="fixed inset-0 bg-black bg-opacity-50 z-30 md:hidden"
        @click="toggleChat"
      ></div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { MessageCircle, X, MessageSquare, UserCircle2, Info, User, Send } from 'lucide-vue-next'

interface Message {
  type: 'customer' | 'agent'
  text: string
  time: string
}

// State
const isOpen = ref(false)
const unreadCount = ref(1)
const messageInput = ref('')
const isTyping = ref(false)

// Demo messages
const demoMessages = ref<Message[]>([
  {
    type: 'customer',
    text: "I'm interested in custom neon signs for my restaurant.",
    time: '10:30 AM'
  },
  {
    type: 'agent',
    text: "Great! We'd love to help. Can you tell me more about what you're looking for?",
    time: '10:31 AM'
  },
  {
    type: 'customer',
    text: 'I need a logo sign about 2 meters wide with LED neon lighting.',
    time: '10:32 AM'
  },
  {
    type: 'agent',
    text: "Perfect! That sounds like our Custom Logo LED Neon Sign. Let me connect you with our design team to create a mockup for you. Would that work?",
    time: '10:33 AM'
  }
])

// Toggle chat
const toggleChat = () => {
  isOpen.value = !isOpen.value
  if (isOpen.value) {
    unreadCount.value = 0
  }
}

// Send message (demo only)
const sendMessage = () => {
  if (!messageInput.value.trim()) return

  // Add customer message
  demoMessages.value.push({
    type: 'customer',
    text: messageInput.value,
    time: new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })
  })

  messageInput.value = ''

  // Simulate typing indicator
  isTyping.value = true
  
  setTimeout(() => {
    isTyping.value = false
    
    // Add auto-response
    demoMessages.value.push({
      type: 'agent',
      text: "Thanks for your message! This is a demo response. In production, your live chat service will handle real conversations.",
      time: new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })
    })
  }, 2000)
}
</script>
